variable app_service_environment_name {
  description   = "Specifies the name of the App Service enviornment. Changing this forces a new resource to be created."
}

variable front_end_scale_factor {
  default       = 10
  description   = "frontend scale value, could be 10, 15, 20, default set is 10"    
}

variable pricing_tier {
  default       = "I2"
  description   = "pricing tier for servers in ASE, it could be I1, I2 etc" 
}
variable cluster_setting_map {
  type = map(string)
  default = {}
}

variable internal_load_balancing_mode { default = "Web, Publishing"}

variable tags {
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable resource_group_name { }
variable subnet_id { }

variable log_analytics_workspace_id { default = ""}
variable log_analytics_retention_days { default = 0 }

variable diagnostics_name { default = "LOGANALYTICS-DIAGNOSTICS"}
variable diagnostic_log_category_list {
    default = ["AppServiceEnvironmentPlatformLogs"
    ]
}