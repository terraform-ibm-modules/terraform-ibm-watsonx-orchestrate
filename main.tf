locals {
  watsonx_orchestrate_crn           = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_watsonx_orchestrate_instance_crn[0].crn : resource.ibm_resource_instance.orchestrate_instance[0].crn
  watsonx_orchestrate_guid          = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_watsonx_orchestrate_instance_crn[0].guid : resource.ibm_resource_instance.orchestrate_instance[0].guid
  watsonx_orchestrate_name          = var.existing_watsonx_orchestrate_instance_crn != null ? data.ibm_resource_instance.existing_watsonx_orchestrate_instance_crn[0].resource_name : resource.ibm_resource_instance.orchestrate_instance[0].resource_name
  watsonx_orchestrate_plan_id       = var.existing_watsonx_orchestrate_instance_crn != null ? null : resource.ibm_resource_instance.orchestrate_instance[0].resource_plan_id
  watsonx_orchestrate_dashboard_url = var.existing_watsonx_orchestrate_instance_crn != null ? null : resource.ibm_resource_instance.orchestrate_instance[0].dashboard_url
}

########################################################################################################################
# Watsonx Orchestrate Instance
########################################################################################################################


data "ibm_resource_instance" "existing_watsonx_orchestrate_instance_crn" {
  count      = var.existing_watsonx_orchestrate_instance_crn != null ? 1 : 0
  identifier = var.existing_watsonx_orchestrate_instance_crn
}

resource "ibm_resource_instance" "orchestrate_instance" {

  count             = var.existing_watsonx_orchestrate_instance_crn != null ? 0 : var.watsonx_orchestrate_plan == "do not install" ? 0 : 1
  name              = var.watsonx_orchestrate_name
  service           = "watsonx-orchestrate"
  plan              = var.watsonx_orchestrate_plan
  location          = var.region
  resource_group_id = var.resource_group_id

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  lifecycle {
    precondition {
      condition     = contains(["us-south"], var.region)
      error_message = "watsonx Orchestrate is only available in us-south region."
    }
  }
}

##############################################################################
# Attach Access Tags
##############################################################################

resource "ibm_resource_tag" "watsonx_orchestrate_tag" {
  count       = length(var.access_tags) == 0 && var.existing_watsonx_orchestrate_instance_crn == null ? 0 : 1
  resource_id = ibm_resource_instance.orchestrate_instance[0].crn
  tags        = var.access_tags
  tag_type    = "access"
}
