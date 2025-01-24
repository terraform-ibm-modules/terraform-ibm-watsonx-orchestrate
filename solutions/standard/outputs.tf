##############################################################################
# Outputs
##############################################################################

output "account_id" {
  description = "Account ID of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.account_id
}

output "crn" {
  description = "The CRN of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.crn
}

output "guid" {
  description = "The GUID of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.guid
}

output "name" {
  description = "The name of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.name
}

output "plan_id" {
  description = "The plan ID of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.plan_id
}

output "dashboard_url" {
  description = "The dashboard URL of the watsonx Orchestrate instance."
  value       = module.watsonx_orchestrate.dashboard_url
}
