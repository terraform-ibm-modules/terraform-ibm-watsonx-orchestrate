#######################################################################################################################
# Local block
#######################################################################################################################

locals {
  prefix = var.prefix != null ? (var.prefix != "" ? var.prefix : null) : null
}

#######################################################################################################################
# Resource Group
#######################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  existing_resource_group_name = var.existing_resource_group_name
}

#######################################################################################################################
# watsonx Orchestrate
#######################################################################################################################

module "watsonx_orchestrate" {
  source                   = "../../"
  region                   = var.region
  plan                     = var.plan
  resource_group_id        = module.resource_group.resource_group_id
  watsonx_orchestrate_name = try("${local.prefix}-${var.name}", var.name)
  access_tags              = var.access_tags
  resource_tags            = var.resource_tags
}
