########################################################################################################################
# Input Variables
########################################################################################################################
variable "location" {
  default     = "us-south"
  description = "The location that's used with the IBM Cloud Terraform IBM provider. It's also used during resource creation."
  type        = string
  validation {
    condition     = contains(["us-south"], var.location)
    error_message = "You must specify `us-south` as the IBM Cloud location."
  }
}

variable "use_existing_resource_group" {
  type        = bool
  description = "Determines whether to use an existing resource group."
  default     = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of a new or an existing resource group where the resources are created."
}

variable "resource_prefix" {
  description = "The name to be used with watsonx Orchestrate resources as a prefix."
  type        = string
  default     = "watsonx-orchestrate"

  validation {
    condition     = var.resource_prefix != "" && length(var.resource_prefix) <= 25
    error_message = "You must provide a value for the resource_prefix variable and the resource_prefix length can't exceed 25 characters."
  }
}

variable "existing_orchestrate_instance" {
  default     = null
  description = "CRN of the an existing watsonx Orchestrate instance."
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
