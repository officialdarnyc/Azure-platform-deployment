
variable "resource_group_name" {
  type        = string
  description = "(required) Resource group name"
}

variable "location" {
  type        = string
  description = "(required) Azure region"
  default     = "eastus2"
}

variable "virtual_network_name" {
  type = string
  description = "Azure Virtual Network name"
}

variable "subnet_name" {
  type = string
  description = "Subnet name"
}

variable "tags" {
  type        = map(string)
  description = "(optional) resource tag"
}