
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

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Subnets within the VNET"
}

variable "tags" {
  type        = map(string)
  description = "(optional) resource tag"
}