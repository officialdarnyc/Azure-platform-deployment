
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

resource "azurerm_mssql_database" "db" {
  name                             = var.db_name
  server_id                        = azurerm_mssql_server.server.id
  collation                        = var.collation
  license_type                     = var.license_type
  max_size_gb                      = var.max_size_gb
  create_mode                      = var.create_mode
  creation_source_database_id      = var.creation_source_database_id
  recover_database_id              = var.recover_database_id
  read_scale                       = false
  sku_name                         = var.sku_name  
  zone_redundant                   = var.zone_redundant

  tags                             = var.tags
}

resource "azurerm_mssql_virtual_network_rule" "db" {
  name                             = "${var.db_name}-vnetrules"
  server_id                        = azurerm_mssql_server.server.id
  subnet_id                        = var.subnet_id
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