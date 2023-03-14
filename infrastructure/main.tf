locals {
  resource_group_name = "ic"
  location            = "eastus2"
  tags                = {
    environment       = "ic"
  }
}

module "storage_account" {
  source              = "./modules/storage_account"
  name                = "sqlauditstore"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

}

module "appservice_vnet" {
    source                    = "./modules/vnet"
    virtual_network_name      = var.virtual_network_name
    subnet_name               = var.subnet_name 
    resource_group_name       = local.resource_group_name
    location                  = local.location
    tags                      = local.tags 
    
}

module "sqlserver_db" {
    source = "./modules/sql_server"    

    db_name                            = var.db_name
    db_server_name                     = var.sqlserver_name
    sql_administrator_login            = var.sql_admin_username
    sql_administrator_login_password   = var.sql_admin_password
    max_size_gb                        = var.max_size_gb

    auditstore_primary_blob_endpoint   = module.storage_account.primary_blob_endpoint
    auditstore_primary_access_key      = module.storage_account.primary_access_key

    subnet_id                          = module.appservice_vnet.subnet.*.id[0]
    secure_resources                   = var.secure_resources

    resource_group_name                = local.resource_group_name
    location                           = local.location
    tags                               = local.tags

}