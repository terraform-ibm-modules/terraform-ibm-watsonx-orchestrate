module "existing_watsonx_orchestrator_instance" {
  source                                    = "../.."
  existing_watsonx_orchestrate_instance_crn = var.existing_watsonx_orchestrate_instance_crn
}
