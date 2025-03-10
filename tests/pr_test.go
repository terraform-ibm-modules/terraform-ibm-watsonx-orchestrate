// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/cloudinfo"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group
const resourceGroup = "geretain-test-resources"
const basicExampleDir = "examples/basic"
const existingExampleDir = "examples/existing-instance"
const standardSolutionTerraformDir = "solutions/fully-configurable"

// Define a struct with fields that match the structure of the YAML data
const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

var permanentResources map[string]interface{}
var sharedInfoSvc *cloudinfo.CloudInfoService

// Current supported regions
var validRegions = []string{
	"us-south",
	"eu-gb",
	"ca-tor",
}

func TestMain(m *testing.M) {
	sharedInfoSvc, _ = cloudinfo.NewCloudInfoServiceFromEnv("TF_VAR_ibmcloud_api_key", cloudinfo.CloudInfoServiceOptions{})
	// Read the YAML file content
	var err error
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
		"region":         validRegions[rand.Intn(len(validRegions))],
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
			"access_tags":   permanentResources["accessTags"],
			"region":        validRegions[rand.Intn(len(validRegions))],
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

func TestRunStandardSolution(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  standardSolutionTerraformDir,
		Region:        validRegions[rand.Intn(len(validRegions))],
		Prefix:        "wxo-da",
		ResourceGroup: resourceGroup,
	})

	options.TerraformVars = map[string]interface{}{
		"watsonx_orchestrate_plan":     "standard",
		"provider_visibility":          "public",
		"existing_resource_group_name": resourceGroup,
		"prefix":                       options.Prefix,
		"region":                       options.Region,
	}

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunStandardUpgradeSolution(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  standardSolutionTerraformDir,
		Region:        validRegions[rand.Intn(len(validRegions))],
		Prefix:        "wxo-da-upg",
		ResourceGroup: resourceGroup,
	})

	options.TerraformVars = map[string]interface{}{
		"watsonx_orchestrate_plan":     "standard",
		"provider_visibility":          "public",
		"existing_resource_group_name": resourceGroup,
		"prefix":                       options.Prefix,
		"region":                       options.Region,
	}

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
