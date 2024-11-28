########################################################################################################################
# Input variables
########################################################################################################################
variable "ibmcloud_api_key" {
  description = "The IBM Cloud API Key"
  sensitive   = true
  type        = string
}

variable "existing_watsonx_orchestrate_instance_crn" {
  default     = null
  description = "The CRN of the an existing watsonx.orchestrate instance. If no value is passed, and new instance will be provisioned"
  type        = string
}

variable "region" {
  default     = "us-south"
  description = "Region to provision all resources created by this example."
  type        = string
}
