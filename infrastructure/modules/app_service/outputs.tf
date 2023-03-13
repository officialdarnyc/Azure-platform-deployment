output "principal_id" {
  value = azurerm_app_service.appsvc.identity.0.principal_id
}


output "id" {
  value = azurerm_app_service.appsvc.id
}