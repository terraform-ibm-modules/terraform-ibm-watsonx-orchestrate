########################################################################################################################
# Outputs
########################################################################################################################

output "name" {
  description = "The name of the watsonx Orchestrate instance."
  value       = module.existing_watsonx_orchestrator_instance.watsonx_orchestrate_name
}
