
resource "azurerm_virtual_network" "vnet" {
    name                = var.virtual_network_name
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.resource_group_name

    tags               = var.tags
}

resource "azurerm_subnet" "snet" {
  for_each   = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

}
