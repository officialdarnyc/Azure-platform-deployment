output "ase_id" {
  value         = azurerm_app_service_environment.app_service_environment.id 
  description   = "output the ase id for future use purpose"
}
output "resource_group_name" {
  value         = azurerm_app_service_environment.app_service_environment.resource_group_name
  description   = "resource group name in which ASE is created"
}
output "location" {
  value         = azurerm_app_service_environment.app_service_environment.location
  description   = "resource group name in which ASE is created"
}