########################################################################################################################
# Watsonx Orchestrator instance
########################################################################################################################


module "watsonx_orchestrator" {
  source                      = "../.."
  location                    = "us-south"
  use_existing_resource_group = false
  resource_group_name         = "watsonx-orch-resource-group"
  resource_prefix             = var.resource_prefix
  watsonx_orchestrate_plan    = "standard"
}
