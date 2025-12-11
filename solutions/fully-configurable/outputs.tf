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

output "next_steps_text" {
  value       = "Now, you can launch the Watsonx Orchestrate tool and create your agents."
  description = "Next steps text"
}

output "next_step_primary_label" {
  value       = "Go to Watsonx Orchestrate instance dashboard"
  description = "Primary label"
}

output "next_step_primary_url" {
  value       = "${module.watsonx_orchestrate.dashboard_url}?paneId=manage"
  description = "Primary URL"
}

output "next_step_secondary_label" {
  value       = "Learn more about Watsonx Orchestrate"
  description = "Secondary label"
}

output "next_step_secondary_url" {
  value       = "https://www.ibm.com/docs/en/watsonx/watson-orchestrate/base?topic=getting-started-watsonx-orchestrate"
  description = "Secondary URL"
}
