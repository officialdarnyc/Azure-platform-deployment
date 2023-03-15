output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "snet_id" {
  value = values(azurerm_subnet.snet)[*].id
}   