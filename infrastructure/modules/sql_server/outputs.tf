output name {
  value = azurerm_mssql_server.server.name
}
output id {
  value = azurerm_mssql_server.server.id
}

output default_secondary_location {
  value       = azurerm_mssql_database.db.default_secondary_location
}

output private_endpoint_fqdn {
  value = local.fqdn
}

output private_endpoint_ip_address {
  value = local.ip_address
}