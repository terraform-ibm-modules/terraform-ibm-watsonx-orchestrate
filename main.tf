locals {
  account_id                        = var.existing_watsonx_orchestrate_instance_crn != null ? module.crn_parser[0].account_id : ibm_resource_instance.watsonx_orchestrate_instance[0].account_id
  watsonx_orchestrate_id            = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].id : ibm_resource_instance.watsonx_orchestrate_instance[0].id
  watsonx_orchestrate_crn           = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].crn : ibm_resource_instance.watsonx_orchestrate_instance[0].crn
  watsonx_orchestrate_guid          = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].guid : ibm_resource_instance.watsonx_orchestrate_instance[0].guid
  watsonx_orchestrate_name          = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_orchestrate_instance[0].resource_name : ibm_resource_instance.watsonx_orchestrate_instance[0].resource_name
  watsonx_orchestrate_plan_id       = var.existing_watsonx_orchestrate_instance_crn != null ? null : ibm_resource_instance.watsonx_orchestrate_instance[0].resource_plan_id
  raw_crn                           = "crn:v1:bluemix:public:watsonx-orchestrate:${var.region}:a/${local.account_id}:${local.watsonx_orchestrate_guid}::"
  watsonx_orchestrate_dashboard_url = "https://cloud.ibm.com/services/watsonx-orchestrate/${urlencode(local.raw_crn)}"
}

module "crn_parser" {
  count   = var.existing_watsonx_orchestrate_instance_crn != null ? 1 : 0
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.1.0"
  crn     = var.existing_watsonx_orchestrate_instance_crn
}


data "ibm_resource_instance" "existing_orchestrate_instance" {
  count      = var.existing_watsonx_orchestrate_instance_crn != null ? 1 : 0
  identifier = var.existing_watsonx_orchestrate_instance_crn
}

resource "ibm_resource_instance" "watsonx_orchestrate_instance" {
  count             = var.existing_watsonx_orchestrate_instance_crn != null ? 0 : 1
  resource_group_id = var.resource_group_id
  name              = var.watsonx_orchestrate_name
  location          = var.region
  service           = "watsonx-orchestrate"
  plan              = var.plan
  tags              = var.resource_tags

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

##############################################################################
# Attach Access Tags
##############################################################################

resource "ibm_resource_tag" "watsonx_orchestrate_tag" {
  count       = length(var.access_tags) == 0 ? 0 : 1
  resource_id = local.watsonx_orchestrate_crn
  tags        = var.access_tags
  tag_type    = "access"
}
