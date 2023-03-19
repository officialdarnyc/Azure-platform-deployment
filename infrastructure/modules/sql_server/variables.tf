variable resource_group_name {
  type = string
  description = "Resource group name that the database will be created in."
}

variable location {
  type = string
  description = "The location/region where the database and server are created. Changing this forces a new resource to be created."
}

variable server_version {
  type = string
  description = "The version for the database server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
}
variable zone_redundant {
  type = bool
  default = false
}
variable db_name {
  type = string
  description = "The name of the database to be created."
}
variable db_server_name {
  type = string
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

variable create_mode {
  type = string
  description = "Specifies the mode of database creation. Can be 'Default' or 'Restore'."
  default = "Default"
}

variable creation_source_database_id {
  type = string
  description = "The source database id to restore from."
  default = null
}

variable sku_name {
    type = string
    description = "Specifies the name of the SKU used by the database"
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

variable auditstore_primary_blob_endpoint {
  type = string
  description = "The primary blob endpoint of the audit store."
}
variable auditstore_primary_access_key {
  type = string
  description = "The primary access key of the audit store."
}
variable auditstore_retention_days {
  type = number
  description = "The number of days to retain audit logs in the audit store."
  default = 20 
}

variable subnet_id {
    type = string
    description = "Azure subnet ID"
}

variable tags {
  description = "The resource tags"
  type        = map
}
