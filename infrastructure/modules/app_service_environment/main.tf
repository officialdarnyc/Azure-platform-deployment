locals {
  # needed for the dynamic block for log analytics
  log_category_map = {
      for category in var.diagnostic_log_category_list:
          category => category
  }
}

resource "azurerm_app_service_environment" "app_service_environment" {
  name                          = var.app_service_environment_name
  subnet_id                     = var.subnet_id
  pricing_tier                  = var.pricing_tier
  front_end_scale_factor        = var.front_end_scale_factor
  tags                          = var.tags
  resource_group_name           = var.resource_group_name
  internal_load_balancing_mode  = var.internal_load_balancing_mode

  dynamic "cluster_setting" {
    for_each = var.cluster_setting_map
    content {
      name  = cluster_setting.key
      value = cluster_setting.value
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "app_service_environmentdiag" {
  name                            = var.diagnostics_name
  count                           = var.log_analytics_workspace_id == "" ? 0 : 1
  target_resource_id              = azurerm_app_service_environment.app_service_environment.id
  log_analytics_workspace_id      = var.log_analytics_workspace_id

  # App Service Environments don't support metrics

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

