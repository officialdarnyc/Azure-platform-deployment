locals {
  fqdn        = azurerm_private_endpoint.server.custom_dns_configs[0].fqdn
  ip_address  = azurerm_private_endpoint.server.custom_dns_configs[0].ip_addresses[0]
}

resource "azurerm_mssql_server" "server" {
  name                         = lower(var.db_server_name)
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.server_version
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_login_password
  connection_policy            = var.connection_policy
  
  tags                         = var.tags
}

resource "azurerm_private_endpoint" "server" {
  name                = "PRIVATELINK-SQL-${upper(azurerm_mssql_server.server.name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = azurerm_mssql_server.server.name
    private_connection_resource_id = azurerm_mssql_server.server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
  tags                             = var.tags  
}

resource "azurerm_mssql_database" "db" {
  name                             = var.db_name
  server_id                        = azurerm_mssql_server.server.id
  collation                        = var.collation
  license_type                     = var.license_type
  max_size_gb                      = var.max_size_gb
  create_mode                      = "Default"
  read_scale                       = false
  sku_name                         = var.sku_name  
  zone_redundant                   = var.zone_redundant

  tags                             = var.tags
}

resource "azurerm_mssql_firewall_rule" "fw" {
  name                = "${var.db_name}-fwrules"
  server_id           = azurerm_mssql_server.server.id
  start_ip_address    = var.secure_resources ? local.ip_address  : var.start_ip_address
  end_ip_address      = var.secure_resources ? local.ip_address  : var.end_ip_address

}

resource "azurerm_mssql_server_extended_auditing_policy" "audit_policy" {
  server_id                               = azurerm_mssql_server.server.id
  storage_endpoint                        = var.auditstore_primary_blob_endpoint
  storage_account_access_key              = var.auditstore_primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.auditstore_retention_days

}

resource "azurerm_mssql_database_extended_auditing_policy" "audit_policy" {
  database_id                             = azurerm_mssql_database.db.id
  storage_endpoint                        = var.auditstore_primary_blob_endpoint
  storage_account_access_key              = var.auditstore_primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.auditstore_retention_days
}