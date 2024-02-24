variable "common" {
  type    = string
  default = "rg-01"
}
variable "common_nsg" {
  type    = string
  default = "nsg01"
}
variable "var_vnet_name" {
  description = "virtual network name"
  type        = string
  default     = "vnet01"
}
variable "var_vnet_address_space" {
  description = "virtual network address space"
  type        = string
  default     = "[10.01.0.0/25]"
}
variable "var_vnet_dns_servers" {
  description = "virtual network dns servers name"
  type        = string
  default     = "[10.0.0.0]"
}
variable "var_subnet" {
  description = "subnet values that needs to attach to vnet"
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {
    "sname01" = {
      name           = "subnet01"
      address_prefix = "[10.0.0.0/32]"
    }
    "sname02" = {
      name           = "subnet02"
      address_prefix = "[10.1.0.0/32]"
    }
  }
}
