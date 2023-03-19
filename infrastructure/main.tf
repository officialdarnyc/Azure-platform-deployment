locals {
  resource_group_name = "ic"
  location            = var.location
  tags                = {
    environment       = "ic"
  }
}

module "storage_account" {
  source              = "./modules/storage_account"
  name                = "sqlauditstoreikecus"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

}

module "vnet" {
    source                    = "./modules/vnet"
    virtual_network_name      = var.virtual_network_name
    subnets                   = var.subnets
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
    sku_name                           = var.sql_sku_name
    create_mode                        = var.create_mode
    creation_source_database_id        = var.creation_source_database_id

    auditstore_primary_blob_endpoint   = module.storage_account.primary_blob_endpoint
    auditstore_primary_access_key      = module.storage_account.primary_access_key

    subnet_id                          = module.vnet.snet_id[0]

    resource_group_name                = local.resource_group_name
    location                           = local.location
    tags                               = local.tags

}

module "app_service_environment" {
    source = "./modules/app_service_environment"  
    count = var.use_ase ? 1 : 0  

    app_service_environment_name  = var.app_service_environment_name
    resource_group_name           = local.resource_group_name
    cluster_setting_map           = var.cluster_setting_map
    subnet_id                     = module.vnet.snet_id[1]

    tags                          = local.tags
    
}

module "app_service_plan" {
    source = "./modules/app_service_plan"    

    ase_plan_name                 = "${var.app_service_environment_name}-plan"
    app_service_environment_id    = var.use_ase ? module.app_service_environment[0].ase_id : null
    resource_group_name           = local.resource_group_name
    location                      = local.location
    os_type                       = "Linux"
    sku_name                      = "B1"

    tags                          = local.tags
    
}

module "app_service" {
    source = "./modules/app_service"  

    resource_group_name           = local.resource_group_name
    location                      = local.location
    appsvc_name                   = var.appsvc_name 
    ase_plan_id                   = module.app_service_plan.asp_id
    app_settings                  = {}
    site_config                   = var.site_config
    app_service_enabled           = true    
    https_only                    = false
    client_affinity_enabled       = false
    client_certificate_enabled    = false
    vnet_subnet_id                = module.vnet.snet_id[0]
    enable_auth_settings          = false
    connection_string_name        = var.connection_string_name
    db_type                       = var.db_type
    connection_string_value       = var.connection_string_value

    tags                          = local.tags

}