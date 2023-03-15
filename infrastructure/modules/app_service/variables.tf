variable "resource_group_name" {
  type = string
  description = "The name of the resource group"
}

variable "location" {
  type = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "appsvc_name" {
  type = string
  description = "(required) App service name"
}

variable "ase_plan_id" { }        
variable "tags" { }

variable "app_settings" {
    description = "A key-value pair of App Settings"
    type        = map(string)
    default     = {}
}

variable https_only {
  type = bool
  description = "(optional) Should the Linux Web App require HTTPS connections"
}
variable app_service_enabled {
  type = bool
  description = "(optional) Should the Linux Web App be enabled"
}

variable client_certificate_enabled {
  type = bool
  description = "(optional) Should the Linux Web App require a client certificate"
  default = null 
}
variable client_affinity_enabled {
  type = bool
  description = "(optional) Should the Linux Web App be enabled to support client affinity"
  default = null 
}

variable vnet_subnet_id {
  type = string
  description = "(optional) VNet Subnet ID"
}

variable connection_string_name {
  type = string
  description = "(optional) The name of the connection string"
}

variable db_type {
  type = string
  description = "(optional) The database type. Possible values: 'SQLServer', MySQL', 'PostgreSQL' or 'SQLAzure'"
}

variable connection_string_value {
  type = string
  description = "(optional) The connection string value"
}


variable site_config {
  default = null
}


variable log_analytics_workspace_id { default = ""}
variable log_analytics_retention_days { default = 0 }

variable diagnostics_name { default = "LOGANALYTICS-DIAGNOSTICS"}
variable diagnostic_log_category_list {
    default = ["AppServiceAntivirusScanAuditLogs"
      , "AppServiceHTTPLogs"
      , "AppServiceConsoleLogs"
      , "AppServiceAppLogs"
      , "AppServiceFileAuditLogs"
      , "AppServiceAuditLogs"
      , "AppServiceIPSecAuditLogs"
      , "AppServicePlatformLogs"
    ]
}