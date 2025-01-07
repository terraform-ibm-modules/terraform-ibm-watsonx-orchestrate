########################################################################################################################
# Outputs
########################################################################################################################

output "account_id" {
  description = "Account ID of the watsonx Orchestrate instance."
  value       = local.account_id
}

output "id" {
  description = "ID of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_id
}

output "crn" {
  description = "The CRN of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_crn
}

output "guid" {
  description = "The GUID of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_guid
}

output "name" {
  description = "The name of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_name
}

output "plan_id" {
  description = "The plan ID of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_plan_id
}

output "dashboard_url" {
  description = "The dashboard URL of the watsonx Orchestrate instance."
  value       = local.watsonx_orchestrate_dashboard_url
}
