virtual_network_name   = "ic-skedda-vnet"
subnets = {
  "PrivateLinkSubnet" = {
    address_prefixes = [ "10.0.1.0/24" ]
  },
  "asesubnet" = {
    address_prefixes = [ "10.0.2.0/24" ]
  }
}

db_name                = "DotNetAppDB"
sqlserver_name         = "AppDBServer-ike"
max_size_gb            = 5
sku_name               = "S0"

app_service_environment_name = "icdotnetenv"
cluster_setting_map = {
    "DisableTls1.0" = "1"
}

appsvc_name            = "ikedotnetapp01"
connection_string_name = "DbConnectionString"
db_type                = "SQLServer"

site_config = {
    always_on = "true"
}
