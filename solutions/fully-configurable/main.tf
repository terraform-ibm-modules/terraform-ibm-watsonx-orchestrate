#######################################################################################################################
# Local block
#######################################################################################################################

locals {
  prefix = var.prefix != null ? trimspace(var.prefix) != "" ? "${var.prefix}-" : "" : ""
}

#######################################################################################################################
# Resource Group
#######################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.4.8"
  existing_resource_group_name = var.existing_resource_group_name
}

#######################################################################################################################
# watsonx Orchestrate
#######################################################################################################################

module "watsonx_orchestrate" {
  source                   = "../../"
  region                   = var.region
  plan                     = var.service_plan
  resource_group_id        = module.resource_group.resource_group_id
  watsonx_orchestrate_name = var.watsonx_orchestrate_instance_name != null ? "${local.prefix}${var.watsonx_orchestrate_instance_name}" : null
  access_tags              = var.access_tags
  resource_tags            = var.resource_tags
}
