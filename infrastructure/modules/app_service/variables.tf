variable "resource_group_name" {
  description="The name of the resource group in which to create the KeyVault."
}

variable "location" {
  description="Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "appsvc_name" { }
variable "ase_paln_id" { }        
variable "tags" { }

variable "app_settings" {
    description = "A key-value pair of App Settings"
    type        = map(string)
    default     = {}
}

# Providing argument options defaulting to the Azure default
variable https_only { default = null }
variable app_service_enabled { default = null }
variable client_cert_enabled { default = null }
variable client_affinity_enabled { default = null }

variable private_link_ind { default = false }
variable private_link_name { default = null }
variable private_link_subnet_id { default = null }
variable integration_subnet_id { default = null }


variable site_config {
  default = null
}

# UserAssigned is recommended -- SystemAssigned used as it was the default
variable identity {
  type = object({
    type = string
    identity_ids = list(string)
  })
  default = {
    type = "SystemAssigned"
    identity_ids = null
  }
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