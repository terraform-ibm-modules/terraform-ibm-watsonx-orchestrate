########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "existing_watsonx_orchestrate_instance_crn" {
  description = "The CRN of an existing watsonx Orchestrate instance."
  type        = string
}

variable "access_tags" {
  type        = list(string)
  description = "Optional list of access management tags to add to the watsonx Orchestrate instance"
  default     = []
}
