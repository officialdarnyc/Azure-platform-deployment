locals {
  resource_group_name = "ic"
  location            = "eastus2"
  tags                = {
    environment       = "ic"
  }
}

module "appservice_vnet" {
    source                    = "./modules/vnet"
    virtual_network_name      = var.virtual_network_name
    subnet_name               = var.subnet_name 
    resource_group_name       = local.resource_group_name
    location                  = local.location
    tags                      = local.tags 
    
}