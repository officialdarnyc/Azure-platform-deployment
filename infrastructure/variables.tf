
variable "virtual_network_name" {
  type = string
  description = "Azure VNET name"
}

variable "subnet_name" {
  type = string
  description = "Azure Subnet name"
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

variable sku_name {
    type = string
    description = "Specifies the name of the SKU used by the database"
    default = "S0"
}

variable "secure_resources" {
    type = bool
    default = true 
}
