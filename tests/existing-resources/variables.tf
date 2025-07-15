########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix for name of all resource created by this example"
  default     = "wx-orchestrate"
  validation {
    error_message = "Prefix must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([A-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.prefix))
  }
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example."
  default     = "us-south"
}

variable "plan" {
  description = "The plan that is required to provision the watsonx Orchestrate instance. Possible values are: lite, essentials-agentic-mau, standard-agentic-mau and premium-agentic-mau."
  type        = string
  default     = "essentials-agentic-mau"
}

variable "resource_group" {
  type        = string
  description = "The name of an existing resource group to provision resources into. If not set a new resource group will be created using the prefix variable."
  default     = null
}

variable "access_tags" {
  type        = list(string)
  description = "Optional list of access management tags to add to the watsonx Orchestrate instance."
  default     = []
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the created resources."
  default     = []
}
