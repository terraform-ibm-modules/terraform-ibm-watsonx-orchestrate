########################################################################################################################
# Outputs
########################################################################################################################

output "crn" {
  description = "The CRN of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_crn
}

output "guid" {
  description = "The GUID of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_guid
}

output "name" {
  description = "The name of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_name
}

output "id" {
  description = "The plan ID of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_plan_id
}

output "dashboard_url" {
  description = "The dashboard URL of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrator.watsonx_orchestrate_dashboard_url
}
