# Input Variables
# https://www.terraform.io/language/values/variables

variable "billing_account" {
  description = "The alphanumeric ID of the billing account this project belongs to"
  type        = string
  default     = "01C550-A2C86B-B8F16B"
}

variable "cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink benchmark project ID"
  type        = string
}

variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
  sensitive   = true
}

variable "enable_datadog" {
  description = "Enable Datadog integration"
  type        = bool
  default     = false
}

variable "enable_datadog_cloud_cost_management" {
  description = "Enable Datadog cloud cost management"
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment for example: `sandbox`, `non-production`, `production`"
  type        = string
  default     = "sandbox"
}

variable "folder_id" {
  description = "The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified"
  type        = string
}

variable "monthly_budget_amount" {
  description = "The monthly budget amount in USD to set for the project"
  type        = number
  default     = 5
}
