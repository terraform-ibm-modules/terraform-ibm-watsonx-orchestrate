########################################################################################################################
# Outputs
########################################################################################################################

output "name" {
  description = "The name of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_name
}
