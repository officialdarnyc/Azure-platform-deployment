virtual_network_name   = "ic-skedda-vnet"
subnets = {
  "IntegrationSubnet" = {
    address_prefixes           = [ "10.0.1.0/24" ]
    delegation_name            = "vnet-delegation"
    service_delegation_name    = "Microsoft.Web/serverFarms"
    service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  }
}

db_name                = "DotNetAppDB"
sqlserver_name         = "AppDBServer-ike"
max_size_gb            = 5
sql_sku_name           = "S0"
use_ase                = false
appsvc_name            = "ikedotnetapp01"
connection_string_name = "DbConnectionString"
db_type                = "SQLServer"

site_config = {
    always_on = "false"
}
