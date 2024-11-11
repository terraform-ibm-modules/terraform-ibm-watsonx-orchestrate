########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "location" {
  type        = string
  description = "Region to provision all resources created by this example"
  default     = "us-south"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "basic"
}
