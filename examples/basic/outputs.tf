########################################################################################################################
# Outputs
########################################################################################################################

output "account_id" {
  description = "Account ID of the watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.account_id
}

output "crn" {
  description = "CRN of the watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.crn
}

output "guid" {
  description = "GUID of the watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.guid
}

output "name" {
  description = "Name of the watsonx orchestrate instance"
  value       = module.watsonx_orchestrate.name
}

output "resource_group_id" {
  description = "The resource group ID to provision the watsonx orchestrate instance."
  value       = module.resource_group.resource_group_id
}

output "resource_group_name" {
  description = "The resource group name to provision the watsonx orchestrate instance."
  value       = module.resource_group.resource_group_name
}
