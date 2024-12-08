########################################################################################################################
# Resource Group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Watsonx Orchestrator instance
########################################################################################################################


module "watsonx_orchestrator" {
  source                   = "../.."
  region                   = var.region
  resource_group_id        = module.resource_group.resource_group_id
  watsonx_orchestrate_name = "${var.prefix}-orchestrate-instance"
  watsonx_orchestrate_plan = "standard"
  access_tags              = var.access_tags
  resource_tags            = var.resource_tags
}
