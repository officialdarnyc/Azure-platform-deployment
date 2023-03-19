location   = "centralus"

virtual_network_name   = "ic-skedda-vnet-cus"
subnets = {
  "IntegrationSubnet" = {
    address_prefixes           = [ "10.0.1.0/24" ]
    service_endpoints          = ["Microsoft.Sql"]
    delegation_name            = "vnet-delegation"
    service_delegation_name    = "Microsoft.Web/serverFarms"
    service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  }
}
use_ase                        = false

create_mode                    = "Recovery"
db_name                        = "DotNetAppDBcus"
sqlserver_name                 = "AppDBServer-ike-cus"
max_size_gb                    = 5
sql_sku_name                   = "S0"
appsvc_name                    = "ikedotnetapp01cus"
connection_string_name         = "DbConnectionString"
db_type                        = "SQLServer"

site_config = {
    always_on = "true"
}
