// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"log"
	"os"
	"strings"
	"testing"

	"github.com/IBM/go-sdk-core/v5/core"
	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/cloudinfo"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testaddons"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

// Use existing resource group
const resourceGroup = "geretain-test-resources"
const basicExampleDir = "examples/basic"
const existingExampleDir = "examples/existing-instance"
const fullyConfigurableSolutionTerraformDir = "solutions/fully-configurable"
const terraformVersion = "terraform_v1.12.2" // This should match the version in the ibm_catalog.json

// Define a struct with fields that match the structure of the YAML data
const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

var permanentResources map[string]interface{}
var sharedInfoSvc *cloudinfo.CloudInfoService

// Current supported regions
var validRegions = []string{
	"us-south",
	"ca-tor",
	"eu-gb",
	"eu-de",
	"au-syd",
	"jp-tok",
}

func TestMain(m *testing.M) {
	var err error
	sharedInfoSvc, err = cloudinfo.NewCloudInfoServiceFromEnv("TF_VAR_ibmcloud_api_key", cloudinfo.CloudInfoServiceOptions{})
	if err != nil {
		log.Fatal(err)
	}
	// Read the YAML file content
	permanentResources, err = common.LoadMapFromYaml(yamlLocation)
	if err != nil {
		log.Fatal(err)
	}

	os.Exit(m.Run())
}

func setupOptions(t *testing.T, prefix string, exampleDir string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  exampleDir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
	})
	options.TerraformVars = map[string]interface{}{
		"access_tags":    permanentResources["accessTags"],
		"region":         validRegions[common.CryptoIntn(len(validRegions))],
		"prefix":         options.Prefix,
		"resource_group": resourceGroup,
		"resource_tags":  options.Tags,
	}
	return options
}

func TestRunBasicExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "wxo-basic", basicExampleDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunExistingResourcesExample(t *testing.T) {
	t.Parallel()

	// Provision watsonx Orchestrate instance
	prefix := fmt.Sprintf("ex-wxo-%s", strings.ToLower(random.UniqueId()))
	realTerraformDir := ".."
	tempTerraformDir, _ := files.CopyTerraformFolderToTemp(realTerraformDir, fmt.Sprintf(prefix+"-%s", strings.ToLower(random.UniqueId())))
	tags := common.GetTagsFromTravis()

	// Verify ibmcloud_api_key variable is set
	checkVariable := "TF_VAR_ibmcloud_api_key"
	val, present := os.LookupEnv(checkVariable)
	require.True(t, present, checkVariable+" environment variable not set")
	require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	logger.Log(t, "Tempdir: ", tempTerraformDir)
	existingTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempTerraformDir + "/tests/existing-resources",
		Vars: map[string]interface{}{
			"prefix":        prefix,
			"resource_tags": tags,
			"plan":          "essentials-agentic-mau",
			"access_tags":   permanentResources["accessTags"],
			"region":        validRegions[common.CryptoIntn(len(validRegions))],
		},
		// Set Upgrade to true to ensure latest version of providers and modules are used by terratest.
		// This is the same as setting the -upgrade=true flag with terraform.
		Upgrade: true,
	})

	terraform.WorkspaceSelectOrNew(t, existingTerraformOptions, prefix)
	_, existErr := terraform.InitAndApplyE(t, existingTerraformOptions)
	if existErr != nil {
		assert.True(t, existErr == nil, "Init and Apply of temp existing resource failed")
	} else {
		outputs, err := terraform.OutputAllE(t, existingTerraformOptions)
		require.NoError(t, err, "Failed to retrieve Terraform outputs")
		expectedOutputs := []string{"account_id", "id", "crn", "guid", "name", "plan_id", "dashboard_url"}
		_, tfOutputsErr := testhelper.ValidateTerraformOutputs(outputs, expectedOutputs...)
		if assert.Nil(t, tfOutputsErr, tfOutputsErr) {
			options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
				Testing:      t,
				TerraformDir: existingExampleDir,
				// Do not hard fail the test if the implicit destroy steps fail to allow a full destroy of resource to occur
				ImplicitRequired: false,
				TerraformVars: map[string]interface{}{
					"existing_watsonx_orchestrate_instance_crn": terraform.Output(t, existingTerraformOptions, "crn"),
				},
			})
			output, err := options.RunTestConsistency()
			assert.Nil(t, err, "This should not have errored")
			assert.NotNil(t, output, "Expected some output")
		}
	}

	// Check if "DO_NOT_DESTROY_ON_FAILURE" is set
	envVal, _ := os.LookupEnv("DO_NOT_DESTROY_ON_FAILURE")
	// Destroy the temporary existing resources if required
	if t.Failed() && strings.ToLower(envVal) == "true" {
		fmt.Println("Terratest failed. Debug the test and delete resources manually.")
	} else {
		logger.Log(t, "START: Destroy (existing resources)")
		terraform.Destroy(t, existingTerraformOptions)
		terraform.WorkspaceDelete(t, existingTerraformOptions, prefix)
		logger.Log(t, "END: Destroy (existing resources)")
	}
}

func setupFullyConfigurableOptions(t *testing.T, prefix string) *testschematic.TestSchematicOptions {
	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing:        t,
		TemplateFolder: fullyConfigurableSolutionTerraformDir,
		Region:         validRegions[common.CryptoIntn(len(validRegions))],
		Prefix:         prefix,
		TarIncludePatterns: []string{
			"*.tf",
			fullyConfigurableSolutionTerraformDir + "/*.tf",
		},
		ResourceGroup:    resourceGroup,
		TerraformVersion: terraformVersion,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "region", Value: options.Region, DataType: "string"},
		{Name: "existing_resource_group_name", Value: resourceGroup, DataType: "string"},
		{Name: "provider_visibility", Value: "private", DataType: "string"},
		{Name: "service_plan", Value: "essentials-agentic-mau", DataType: "string"},
	}
	return options
}

func TestRunFullyConfigurableSolutionSchematics(t *testing.T) {
	t.Parallel()

	options := setupFullyConfigurableOptions(t, "wxo-da")

	err := options.RunSchematicTest()
	assert.Nil(t, err, "This should not have errored")
}

func TestRunFullyConfigurableUpgradeSolutionSchematics(t *testing.T) {
	t.Parallel()

	options := setupFullyConfigurableOptions(t, "wxo-upg")
	options.CheckApplyResultForUpgrade = true

	err := options.RunSchematicUpgradeTest()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
	}
}

func TestDefaultConfiguration(t *testing.T) {
	t.Parallel()

	options := testaddons.TestAddonsOptionsDefault(&testaddons.TestAddonOptions{
		Testing:       t,
		Prefix:        "wxordeft",
		ResourceGroup: resourceGroup,
		QuietMode:     true, // Suppress logs except on failure
	})

	options.AddonConfig = cloudinfo.NewAddonConfigTerraform(
		options.Prefix,
		"deploy-arch-ibm-watsonx-orchestrate",
		"fully-configurable",
		map[string]interface{}{
			"existing_resource_group_name": resourceGroup,
		},
	)
	// Disable target / route creation to prevent hitting quota in account
	options.AddonConfig.Dependencies = []cloudinfo.AddonConfig{
		{
			OfferingName:   "deploy-arch-ibm-cloud-monitoring",
			OfferingFlavor: "fully-configurable",
			Inputs: map[string]interface{}{
				"enable_metrics_routing_to_cloud_monitoring": false,
			},
			Enabled: core.BoolPtr(true),
		},
		{
			OfferingName:   "deploy-arch-ibm-activity-tracker",
			OfferingFlavor: "fully-configurable",
			Inputs: map[string]interface{}{
				"enable_activity_tracker_event_routing_to_cloud_logs": false,
			},
			Enabled: core.BoolPtr(true),
		},
	}

	err := options.RunAddonTest()
	require.NoError(t, err)
}
