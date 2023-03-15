
resource "azurerm_service_plan" "plan" {
  name                         = var.ase_plan_name
  location                     = var.location
  resource_group_name          = var.resource_group_name

  app_service_environment_id   = var.app_service_environment_id
  os_type                      = var.os_type
  tags                         = var.tags

  sku_name                     = var.sku_name

}

resource "azurerm_monitor_diagnostic_setting" "plan_diag" {
  count   = var.log_analytics_workspace_id != "" ? 1 : 0

  name                            = var.diagnostics_name
  target_resource_id              = azurerm_service_plan.plan.id
  log_analytics_workspace_id      = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
      days = var.log_analytics_retention_days
    }
  }
}