########################################################################################################################
# Outputs
########################################################################################################################

output "account_id" {
  description = "Account ID of the existing watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.account_id
}

output "id" {
  description = "ID of the watsonx orchestrate instance."
  value       = module.watsonx_orchestrate.id
}

output "crn" {
  description = "CRN of the existing watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.crn
}

output "name" {
  description = "Name of the existing watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.name
}

output "guid" {
  description = "GUID of the existing watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.guid
}

output "plan_id" {
  description = "Plan ID of the existing watsonx orchestrate instance."
  value       = module.watsonx_orchestrate.plan_id
}

output "dashboard_url" {
  description = "Dashboard URL of the existing watsonx orchestrate instance."
  value       = module.watsonx_orchestrate.dashboard_url
}
