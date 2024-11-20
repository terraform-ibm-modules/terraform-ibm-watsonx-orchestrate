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

output "resource_group_id" {
  description = "The resource group ID to provision the watsonx.data instance."
  value       = module.resource_group.resource_group_id
}

output "resource_group_name" {
  description = "The resource group name to provision the watsonx.data instance."
  value       = module.resource_group.resource_group_name
}
