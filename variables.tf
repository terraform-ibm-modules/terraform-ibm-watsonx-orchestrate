########################################################################################################################
# Input Variables
########################################################################################################################
variable "watsonx_orchestrate_name" {
  type        = string
  description = "The name of the watsonx.orchestrate instance."
  default     = "watsonx-orchestrate"
}

variable "resource_group_id" {
  description = "The resource group ID where the watsonx data instance is created."
  type        = string
}

variable "region" {
  default     = "us-south"
  description = "The location that's used with the IBM Cloud Terraform IBM provider. It's also used during resource creation."
  type        = string
  validation {
    condition     = contains(["us-south"], var.region)
    error_message = "You must specify `us-south` as the IBM Cloud location."
  }
}
variable "existing_watsonx_orchestrate_instance_crn" {
  default     = null
  description = "The CRN of the an existing watsonx.orchestrate instance. If no value is passed, and new instance will be provisioned"
  type        = string
}

variable "watsonx_orchestrate_plan" {
  default     = "standard"
  description = "The plan that's used to provision the watsonx Orchestrate instance."
  type        = string
  validation {
    condition = anytrue([
      var.watsonx_orchestrate_plan == "essentials",
      var.watsonx_orchestrate_plan == "standard",
    ])
    error_message = "You must use a essentials or standard plan."
  }
}
