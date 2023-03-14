variable resource_group_name {
  description = "Resource group name that the database will be created in."
}

variable location {
  description = "The location/region where the database and server are created. Changing this forces a new resource to be created."
}

variable server_version {
  description = "The version for the database server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
}
variable zone_redundant {
  default = false
}
variable db_name {
  description = "The name of the database to be created."
}
variable db_server_name {
  description ="The Name of the Database server name"
}

variable collation {
    type = string
    description = "The collation for the database. Default is SQL_Latin1_General_CP1_CI_AS"
    default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable license_type {
    type = string
    description = "Specifies the license type applied to the database"
    default = "BasePrice"
}

variable max_size_gb {
    type = number
    description = "The max size of the database in gigabytes."
}

variable sku_name {
    type = string
    description = "Specifies the name of the SKU used by the database"
    default = "Basic"
}

variable sql_administrator_login {
  description = "The administrator username of the SQL Server."
}

variable sql_administrator_login_password {
  description = "The administrator password of the SQL Server."
}

variable connection_policy {
  description = "The connection policy the server will use"
  default = "Default"
}
variable start_ip_address {
  description = "Defines the start IP address used in your database firewall rule."
  default     = "0.0.0.0"
}

variable end_ip_address {
  description = "Defines the end IP address used in your database firewall rule."
  default     = "0.0.0.0"
}

variable auditstore_primary_blob_endpoint {}
variable auditstore_primary_access_key {}
variable auditstore_retention_days { default = 20 }
variable subnet_id {
    type = string
    description = "Azure subnet ID"
}
variable secure_resources {
    type = bool
    default = true 
}

variable tags {
  description = "The resource tags"
  type        = map
}
