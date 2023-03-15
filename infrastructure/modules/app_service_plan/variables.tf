variable "ase_plan_name" {
  type = string
  description   = "Name which should be used for the Service Plan"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
}

variable "resource_group_name" {}
variable "location" {}

variable "app_service_environment_id" { default = null }

variable "os_type" {
  type = string
  description = "(required) The O/S type for the App Services to be hosted"
}

variable "sku_name" {
  type = string
  description = "(required) SKU for the plan"
}

variable log_analytics_workspace_id { default = ""}
variable log_analytics_retention_days { default = 0 }

variable diagnostics_name { default = "LOGANALYTICS-DIAGNOSTICS"}
