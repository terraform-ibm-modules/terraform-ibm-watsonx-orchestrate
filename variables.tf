########################################################################################################################
# Input Variables
########################################################################################################################
variable "watsonx_orchestrate_name" {
  type        = string
  description = "The name of the watsonx.orchestrate instance."
  default     = null

  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn == null ? length(var.watsonx_orchestrate_name) > 0 : true
    error_message = "You must specify a value for 'watsonx_data_name' if 'existing_watsonx_orchestrate_instance_crn' is null."
  }
}

variable "resource_group_id" {
  description = "The resource group ID where the watsonx data instance is created."
  type        = string
   default     = null

  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn == null ? length(var.resource_group_id) > 0 : true
    error_message = "You must specify a value for 'resource_group_id' if 'existing_watsonx_orchestrate_instance_crn' is null."
  }
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
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
  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn == null ? length(var.watsonx_orchestrate_name) > 0 : true
    error_message = "You must specify a value for 'watsonx_orchestrate_name' if 'existing_watsonx_orchestrate_instance_crn' is null."
  }
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

variable "access_tags" {
  type        = list(string)
  description = "A list of access tags to apply to the Key Protect instance created by the module. For more information, see https://cloud.ibm.com/docs/account?topic=account-access-tags-tutorial."
  default     = []

  validation {
    condition = alltrue([
      for tag in var.access_tags : can(regex("[\\w\\-_\\.]+:[\\w\\-_\\.]+", tag)) && length(tag) <= 128
    ])
    error_message = "Tags must match the regular expression \"[\\w\\-_\\.]+:[\\w\\-_\\.]+\", see https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#limits for more details"
  }
}
