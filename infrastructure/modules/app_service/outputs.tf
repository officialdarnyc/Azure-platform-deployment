output "principal_id" {
  value = azurerm_linux_web_app.appsvc.identity.0.principal_id
}


output "id" {
  value = azurerm_linux_web_app.appsvc.id
}