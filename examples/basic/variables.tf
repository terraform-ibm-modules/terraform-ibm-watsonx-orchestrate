########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  description = "The IBM Cloud API Key"
  sensitive   = true
  type        = string
}

variable "prefix" {
  type        = string
  description = "Prefix for name of all resource created by this example"
  default     = "watsonx-orch"
  validation {
    condition     = (var.prefix == null || var.prefix == "") ? true : length(var.prefix) <= 13
    error_message = "prefix length must be 13 characters or less or null or an empty string (\"\")."
  }
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example."
  default     = "us-south"
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
