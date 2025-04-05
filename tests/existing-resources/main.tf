########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.2.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Watsonx Orchestrate
########################################################################################################################

module "watsonx_orchestrate" {
  source                   = "../../"
  region                   = var.region
  watsonx_orchestrate_name = "${var.prefix}-wx-orchestrate"
  plan                     = "essentials"
  resource_group_id        = module.resource_group.resource_group_id
  resource_tags            = var.resource_tags
  access_tags              = var.access_tags
}
