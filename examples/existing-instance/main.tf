########################################################################################################################
# Watsonx Orchestrate
########################################################################################################################

module "existing_watsonx_orchestrate_instance" {
  source                                    = "../../"
  access_tags                               = var.access_tags
  existing_watsonx_orchestrate_instance_crn = var.existing_watsonx_orchestrate_instance_crn
}
