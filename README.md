<!-- Update this title with a descriptive name. Use sentence case. -->
# Terraform modules template project

<!--
Update status and "latest release" badges:
  1. For the status options, see https://terraform-ibm-modules.github.io/documentation/#/badge-status
  2. Update the "latest release" badge to point to the correct module's repo. Replace "terraform-ibm-module-template" in two places.
-->
[![Incubating (Not yet consumable)](https://img.shields.io/badge/status-Incubating%20(Not%20yet%20consumable)-red)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
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

This module is used to provision an instance of the Watsonx Orchestrator service.


<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-watsonx-orchestrate](#terraform-ibm-watsonx-orchestrate)
* [Examples](./examples)
    * [Basic example](./examples/basic)
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

module "watsonx_orchestrator" {
  source = "terraform-ibm-modules/watsonx-orchestrate/ibm"
  version           = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific
  location = "us-south" # pragma: allowlist secret
  resource_group_name = "watsonx-orch-resource-group"
  watsonx_orchestrate_plan = "standard"
}
```

### Required access policies

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.70.1 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.6 |

### Resources

| Name | Type |
|------|------|
| [ibm_resource_instance.orchestrate_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.1/docs/resources/resource_instance) | resource |
| [ibm_resource_instance.existing_orchestrate_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.1/docs/data-sources/resource_instance) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_orchestrate_instance"></a> [existing\_orchestrate\_instance](#input\_existing\_orchestrate\_instance) | CRN of the an existing watsonx Orchestrate instance. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location that's used with the IBM Cloud Terraform IBM provider. It's also used during resource creation. | `string` | `"us-south"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of a new or an existing resource group where the resources are created. | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The name to be used with watsonx Orchestrate resources as a prefix. | `string` | `"watsonx-orchestrate"` | no |
| <a name="input_use_existing_resource_group"></a> [use\_existing\_resource\_group](#input\_use\_existing\_resource\_group) | Determines whether to use an existing resource group. | `bool` | `false` | no |
| <a name="input_watsonx_orchestrate_plan"></a> [watsonx\_orchestrate\_plan](#input\_watsonx\_orchestrate\_plan) | The plan that's used to provision the watsonx Orchestrate instance. | `string` | `"standard"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_watsonx_orchestrate_crn"></a> [watsonx\_orchestrate\_crn](#output\_watsonx\_orchestrate\_crn) | The CRN of the watsonx Orchestrate instance. |
| <a name="output_watsonx_orchestrate_dashboard_url"></a> [watsonx\_orchestrate\_dashboard\_url](#output\_watsonx\_orchestrate\_dashboard\_url) | The dashboard URL of the watsonx Orchestrate instance. |
| <a name="output_watsonx_orchestrate_guid"></a> [watsonx\_orchestrate\_guid](#output\_watsonx\_orchestrate\_guid) | The GUID of the watsonx Orchestrate instance. |
| <a name="output_watsonx_orchestrate_name"></a> [watsonx\_orchestrate\_name](#output\_watsonx\_orchestrate\_name) | The name of the watsonx Orchestrate instance. |
| <a name="output_watsonx_orchestrate_plan_id"></a> [watsonx\_orchestrate\_plan\_id](#output\_watsonx\_orchestrate\_plan\_id) | The plan ID of the watsonx Orchestrate instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
