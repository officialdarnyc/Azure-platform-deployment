variable "location" {
  type = string
  description = "(optional) Azure location for DR"
}

variable "virtual_network_name" {
  type = string
  description = "Azure VNET name"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    service_endpoints = list(string)
    delegation_name = optional(string)
    service_delegation_name = optional(string)
    service_delegation_actions = optional(list(string))
  }))
  description = "Subnets within the VNET"
}


variable "db_name" {
  type = string
  description = "(optional) SQL Database name"
}

variable "sqlserver_name" {
  type = string
  description = "(required) The Name of the Database server name"
}

variable "sql_admin_username" {
  type = string
  description = "(required) SQL administrator login name"
  sensitive = true
}

variable "sql_admin_password" {
  type = string
  description = "(optional) SQL administrator login password"
  sensitive = true
}

variable max_size_gb {
    type = number
    description = "The max size of the database in gigabytes."
}

variable create_mode {
  type = string
  description = "(required) Specifies the mode of database creation. Can be 'Default' or 'Restore'."
}

variable creation_source_database_id {
  type = string
  description = "The source database id to restore from."
}

variable recover_database_id {
  type = string
  description = "(required) The id of the database to be restored from  geo-replicated backup"
}

variable sql_sku_name {
    type = string
    description = "Specifies the name of the SKU used by the database"
    default = "S0"
}

variable app_service_environment_name {
  type = string
  description = "App Service Environment name"
  default = "icdotnetenv"
}
variable cluster_setting_map {
  default = null
}
variable site_config {}
variable log_analytics_workspace_id { default = "" }

variable use_ase {
  type = bool
  default = false
  description = "(optional) Specify whether to enable App Svc Environment"
}

variable "appsvc_name" {
  type = string
  description = "(required) App service name"
}

variable connection_string_name {
  type = string
  description = "(optional) The name of the connection string"
}

variable db_type {
  type = string
  description = "(optional) The database type. Possible values: 'SQLServer', MySQL', 'PostgreSQL' or 'SQLAzure'"
}

variable connection_string_value {
  type = string
  description = "(optional) The connection string value"
  sensitive = true
}