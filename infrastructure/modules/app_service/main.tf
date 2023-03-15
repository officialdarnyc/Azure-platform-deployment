locals {
  # needed for the dynamic block for log analytics
  log_category_map = {
      for category in var.diagnostic_log_category_list:
          category => category
  }
  site_config_map = var.site_config != null ? {one = "one"} : {}
  cors_config_map = try(var.site_config["allowed_origins"], null) != null ? {one = "one"} : {}
}

resource "azurerm_linux_web_app" "appsvc" {
  name                      = var.appsvc_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = var.ase_plan_id
  tags                      = var.tags

  app_settings              = var.app_settings
  https_only                = var.https_only
  enabled                   = var.app_service_enabled
  client_certificate_enabled = var.client_cert_enabled
  client_affinity_enabled   = var.client_affinity_enabled
  
  connection_string {
    name  = var.connection_string_name
    type  = var.db_type
    value = var.connection_string_value

  }

  dynamic site_config {
    for_each = local.site_config_map
    content {
      always_on                 = try(var.site_config["always_on"], null)
      app_command_line          = try(var.site_config["app_command_line"], null)
      dotnet_framework_version  = try(var.site_config["dotnet_framework_version"], null)
      ftps_state                = try(var.site_config["ftps_state"], null)
      health_check_path         = try(var.site_config["health_check_path"], null)
      number_of_workers         = try(var.site_config["number_of_workers"], null)
      http2_enabled             = try(var.site_config["http2_enabled"], null)
      java_version              = try(var.site_config["java_version"], null)
      java_container            = try(var.site_config["java_container"], null)
      java_container_version    = try(var.site_config["java_container_version"], null)
      linux_fx_version          = try(var.site_config["linux_fx_version"], null)
      windows_fx_version        = try(var.site_config["windows_fx_version"], null)
      min_tls_version           = try(var.site_config["min_tls_version"], null) 
      scm_type                  = try(var.site_config["scm_type"], null) 
      websockets_enabled        = try(var.site_config["websockets_enabled"], null) 

      dynamic cors {
        for_each = local.cors_config_map
        content {
          allowed_origins = try(var.site_config["allowed_origins"], [])
        }
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_monitor_diagnostic_setting" "app_service_diag" {
  name                            = var.diagnostics_name
  count                           = var.log_analytics_workspace_id == "" ? 0 : 1
  target_resource_id              = azurerm_linux_web_app.appsvc.id
  log_analytics_workspace_id      = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
      days = var.log_analytics_retention_days
    }
  }

  dynamic "log" {
    for_each = local.log_category_map
    content {
        category = log.key
        enabled  = true

        retention_policy {
          enabled = true
          days = var.log_analytics_retention_days
        }
    }
  }
}