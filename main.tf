locals {
  watsonx_orchestrate_crn           = var.existing_orchestrate_instance != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].crn : resource.ibm_resource_instance.orchestrate_instance[0].crn
  watsonx_orchestrate_guid          = var.existing_orchestrate_instance != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].guid : resource.ibm_resource_instance.orchestrate_instance[0].guid
  watsonx_orchestrate_name          = var.existing_orchestrate_instance != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].resource_name : resource.ibm_resource_instance.orchestrate_instance[0].resource_name
  watsonx_orchestrate_plan_id       = var.existing_orchestrate_instance != null ? null : resource.ibm_resource_instance.orchestrate_instance[0].resource_plan_id
  watsonx_orchestrate_dashboard_url = var.existing_orchestrate_instance != null ? null : resource.ibm_resource_instance.orchestrate_instance[0].dashboard_url
}

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  resource_group_name          = var.use_existing_resource_group == false ? var.resource_group_name : null
  existing_resource_group_name = var.use_existing_resource_group == true ? var.resource_group_name : null
}

data "ibm_resource_instance" "existing_orchestrate_instance" {
  count      = var.existing_orchestrate_instance != null ? 1 : 0
  identifier = var.existing_orchestrate_instance
}

resource "ibm_resource_instance" "orchestrate_instance" {

  count             = var.existing_orchestrate_instance != null ? 0 : var.watsonx_orchestrate_plan == "do not install" ? 0 : 1
  name              = "${var.resource_prefix}-watsonx-orchestrate-instance"
  service           = "watsonx-orchestrate"
  plan              = var.watsonx_orchestrate_plan
  location          = var.location
  resource_group_id = module.resource_group.resource_group_id

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  lifecycle {
    precondition {
      condition     = contains(["us-south"], var.location)
      error_message = "watsonx Orchestrate is only available in us-south region."
    }
  }
}
