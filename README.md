# Terraform IBM Watsonx Orchestrate

<!--
Update status and "latest release" badges:
  1. For the status options, see https://terraform-ibm-modules.github.io/documentation/#/badge-status
  2. Update the "latest release" badge to point to the correct module's repo. Replace "terraform-ibm-module-template" in two places.
-->
[![Graduated (Supported)](https://img.shields.io/badge/status-Graduated%20(Supported)-brightgreen?style=plastic)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-watsonx-orchestrate?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-watsonx-orchestrate/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!--
Add a description of modules in this repo.
Expand on the repo short description in the .github/settings.yml file.

For information, see "Module names and descriptions" at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=module-names-and-descriptions
-->
The IBM watsonx Orchestrate Terraform module is designed to automate the deployment and configuration of the IBM watsonx Orchestrate, a multi-tenant and cloud-native solution that is deployed as a managed software as a service (SaaS) or that you can install on premises.For more information visit [here](https://www.ibm.com/docs/en/watsonx/watson-orchestrate/current)

<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-watsonx-orchestrate](#terraform-ibm-watsonx-orchestrate)
* [Examples](./examples)
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
    * <a href="./examples/basic">Basic example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=watsonx-orchestrate-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-watsonx-orchestrate/tree/main/examples/basic"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
    * <a href="./examples/existing-instance">Existing instance example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=watsonx-orchestrate-existing-instance-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-watsonx-orchestrate/tree/main/examples/existing-instance"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and link to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- Replace this heading with the name of the root level module (the repo name) -->
## terraform-ibm-watsonx-orchestrate

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXXXXXX" # pragma: allowlist secret
  region           = "us-south"
}

module "watsonx_orchestrate" {
  source = "terraform-ibm-modules/watsonx-orchestrate/ibm"
  version           = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific
  region                = "us-south"
  watsonx_orchestrate_name = "example-wx-orchestrate"
  watsonx_orchestrate_plan     = "standard-agentic-mau"
  resource_group_id         = "a8c...8230a" # replace with ID of resource group
}
```

### Required IAM access policies

You need the following permissions to run this module:

* Account Management
  * **Resource Group**
        - `Viewer` role
* IAM Services
  * **watsonx Orchestrate** service
        - `Editor` platform access

To attach access management tags to resources in this module, you need the following permissions.

- IAM Services
    - **Tagging** service
        - `Administrator` platform access


<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the 'Sample IBM Cloud' service and roles with applicable values.
The required information can usually be found in the services official
IBM Cloud documentation.
To view all available service permissions, you can go in the
console at Manage > Access (IAM) > Access groups and click into an existing group
(or create a new one) and in the 'Access' tab click 'Assign access'.
-->

<!--
You need the following permissions to run this module:

- Service
    - **Resource group only**
        - `Viewer` access on the specific resource group
    - **Sample IBM Cloud** service
        - `Editor` platform access
        - `Manager` service access
-->

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->

<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_crn_parser"></a> [crn\_parser](#module\_crn\_parser) | terraform-ibm-modules/common-utilities/ibm//modules/crn-parser | 1.4.1 |

### Resources

| Name | Type |
|------|------|
| [ibm_resource_instance.watsonx_orchestrate_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_instance) | resource |
| [ibm_resource_tag.watsonx_orchestrate_tag](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_tag) | resource |
| [ibm_resource_instance.existing_orchestrate_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_instance) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tags"></a> [access\_tags](#input\_access\_tags) | A list of access tags to apply to the watsonx Orchestrate instance. For more information, see https://cloud.ibm.com/docs/account?topic=account-access-tags-tutorial. | `list(string)` | `[]` | no |
| <a name="input_existing_watsonx_orchestrate_instance_crn"></a> [existing\_watsonx\_orchestrate\_instance\_crn](#input\_existing\_watsonx\_orchestrate\_instance\_crn) | The CRN of an existing watsonx Orchestrate instance.If not provided, a new instance is provisioned. | `string` | `null` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | The plan that is required to provision the watsonx Orchestrate instance. Possible values are: lite, essentials-agentic-mau and standard-agentic-mau. | `string` | `"lite"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the watsonx Orchestrate instance is provisioned. Required to create an instance of watsonx Orchestrate. | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the resource group that contains the watsonx Orchestrate instance. Required to create an instance of watsonx Orchestrate. | `string` | `null` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Optional list of tags to describe the watsonx Orchestrate instance created by the module. | `list(string)` | `[]` | no |
| <a name="input_watsonx_orchestrate_name"></a> [watsonx\_orchestrate\_name](#input\_watsonx\_orchestrate\_name) | The name of the watsonx Orchestrate instance. Required if creating a new instance. | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Account ID of the watsonx Orchestrate instance. |
| <a name="output_crn"></a> [crn](#output\_crn) | The CRN of the watsonx Orchestrate instance. |
| <a name="output_dashboard_url"></a> [dashboard\_url](#output\_dashboard\_url) | The dashboard URL of the watsonx Orchestrate instance. |
| <a name="output_guid"></a> [guid](#output\_guid) | The GUID of the watsonx Orchestrate instance. |
| <a name="output_id"></a> [id](#output\_id) | ID of the watsonx Orchestrate instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the watsonx Orchestrate instance. |
| <a name="output_plan_id"></a> [plan\_id](#output\_plan\_id) | The plan ID of the watsonx Orchestrate instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
