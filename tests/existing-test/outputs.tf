########################################################################################################################
# Outputs
########################################################################################################################

output "crn" {
  description = "The CRN of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_crn
}