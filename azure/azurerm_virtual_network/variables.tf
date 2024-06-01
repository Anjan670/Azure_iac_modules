variable "nsg" {
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(number)
    source_port_ranges           = list(number)
    destination_port_range       = optional(number)
    destination_port_ranges      = list(number)
    source_address_prefix        = optional(string)
    source_address_prefixes      = list(string)
    destination_address_prefix   = optional(string)
    destination_address_prefixes = list(string)
    tags                         = map(string)
  }))
  description = "Map of NSG rules"
}
variable "vnet_subnet" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    address_prefix      = string
    subnet = map(object({
      name           = string
      address_prefix = string
      security_group = string
    }))
    tags = map(string)
  })
}
