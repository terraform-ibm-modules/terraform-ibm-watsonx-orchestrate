########################################################################################################################
# Input Variables
########################################################################################################################

variable "resource_group_id" {
  description = "The resource group ID where the watsonx Orchestrate instance will be grouped. Required when creating a new instance."
  type        = string
  default     = null
  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn == null ? length(var.resource_group_id) > 0 : true
    error_message = "You must specify a value for 'resource_group_id' if 'existing_watsonx_orchestrate_instance_crn' is null."
  }
}

variable "region" {
  description = "Region where the watsonx Orchestrate instance will be provisioned. Required if creating a new instance."
  type        = string
  default     = "us-south"

  validation {
    condition = var.existing_watsonx_orchestrate_instance_crn != null || anytrue([
      var.region == "us-south",
      var.region == "ca-tor",
      var.region == "eu-gb",
      var.region == "eu-de",
      var.region == "au-syd",
      var.region == "jp-tok"
    ])
    error_message = "Region must be specified and set to one of the permitted values ('us-south', 'ca-tor', 'eu-gb', 'eu-de', 'au-syd', 'jp-tok') when provisioning a new instance."
  }
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to describe the watsonx Orchestrate instance created by the module."
  default     = []
}

variable "access_tags" {
  type        = list(string)
  description = "A list of access tags to apply to the watsonx Orchestrate instance. For more information, see https://cloud.ibm.com/docs/account?topic=account-access-tags-tutorial."
  default     = []

  validation {
    condition = alltrue([
      for tag in var.access_tags : can(regex("[\\w\\-_\\.]+:[\\w\\-_\\.]+", tag)) && length(tag) <= 128
    ])
    error_message = "Tags must match the regular expression \"[\\w\\-_\\.]+:[\\w\\-_\\.]+\", see https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#limits for more details"
  }
}

variable "watsonx_orchestrate_name" {
  type        = string
  description = "The name of the watsonx Orchestrate instance. Required if creating a new instance."
  default     = null

  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn == null ? length(var.watsonx_orchestrate_name) > 0 : true
    error_message = "watsonx Orchestrate name must be provided when creating a new instance."
  }
}

variable "existing_watsonx_orchestrate_instance_crn" {
  description = "The CRN of an existing watsonx Orchestrate instance.If not provided, a new instance will be provisioned."
  type        = string
  default     = null
}

variable "plan" {
  description = "The plan that is required to provision the watsonx Orchestrate instance. Possible values are: lite, essentials-agentic-mau, standard-agentic-mau and premium-agentic-mau."
  type        = string
  default     = "lite"
  validation {
    condition     = var.existing_watsonx_orchestrate_instance_crn != null || var.plan != null
    error_message = "watsonx Orchestrate plan must be provided when creating a new instance."
  }
  validation {
    condition = anytrue([
      var.plan == "lite", # This refers to the Trial plan.
      var.plan == "essentials-agentic-mau",
      var.plan == "standard-agentic-mau",
      var.plan == "premium-agentic-mau",
    ]) || var.existing_watsonx_orchestrate_instance_crn != null
    error_message = "A new watsonx Orchestrate instance requires a 'lite', 'essentials-agentic-mau', 'standard-agentic-mau' or 'premium-agentic-mau' plan."
  }
}
