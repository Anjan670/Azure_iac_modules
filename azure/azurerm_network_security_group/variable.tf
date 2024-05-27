variable "common" {
  type    = string
  default = "rg-01"
}
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
  }))
  description = "Map of NSG rules"
  default = {
    rule1 = {
      name                         = "Rule1"
      priority                     = 100
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = [10, 230, 33, 54]
      destination_port_ranges      = [10, 230]
      source_address_prefixes      = ["10.0.0.0/16", "0.0.0.0/0"]
      destination_address_prefixes = ["0.0.0.0/0", "0.0.0.0/0"]
    }
  }
}

