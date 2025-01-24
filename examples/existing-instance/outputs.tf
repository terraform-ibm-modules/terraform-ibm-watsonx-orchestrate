########################################################################################################################
# Outputs
########################################################################################################################

output "crn" {
  description = "CRN of the existing watsonx Orchestrate instance."
  value       = module.existing_watsonx_orchestrate_instance.crn
}

output "account_id" {
  description = "Account ID of the existing watsonx Orchestrate instance"
  value       = module.existing_watsonx_orchestrate_instance.account_id
}

output "id" {
  description = "ID of the watsonx Orchestrate instance."
  value       = module.existing_watsonx_orchestrate_instance.id
}

output "name" {
  description = "Name of the existing watsonx Orchestrate instance"
  value       = module.existing_watsonx_orchestrate_instance.name
}

output "guid" {
  description = "GUID of the existing watsonx Orchestrate instance"
  value       = module.existing_watsonx_orchestrate_instance.guid
}
