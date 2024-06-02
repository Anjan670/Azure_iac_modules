resource "azurerm_network_security_group" "nsg" {
  name                = var.common["name"]
  location            = var.common["location"]
  resource_group_name = var.common["resource_group_name"]

  dynamic "security_rule" {
    for_each = var.nsg
    content {
      name                         = security_rule.value["name"]
      priority                     = security_rule.value["priority"]
      direction                    = security_rule.value["direction"]
      access                       = security_rule.value["access"]
      protocol                     = security_rule.value["protocol"]
      source_port_range            = security_rule.value["source_port_range"] == null ? null : security_rule.value["source_port_range"]
      source_port_ranges           = security_rule.value["source_port_ranges"]
      destination_port_range       = security_rule.value["destination_port_range"] == null ? null : security_rule.value["destination_port_range"]
      destination_port_ranges      = security_rule.value["destination_port_ranges"]
      source_address_prefix        = security_rule.value["source_address_prefix"] == null ? null : security_rule.value["source_address_prefix"]
      source_address_prefixes      = security_rule.value["source_address_prefixes"]
      destination_address_prefix   = security_rule.value["destination_address_prefix"] == null ? null : security_rule.value["destination_address_prefix"]
      destination_address_prefixes = security_rule.value["destination_address_prefixes"]
    }
  }
  tags = var.nsg.tags
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.common["name"]
  location            = var.vnet_subnet["location"]
  resource_group_name = var.vnet_subnet["resource_group_name"]
  address_space       = var.vnet_subnet["address_space"]
  dynamic "subnet" {
    for_each = var.vnet_subnet.subnet
    content {
      name           = subnet.value["name"]
      address_prefix = subnet.value["address_prefix"]
      security_group = subnet.value["security_group"]
    }
  }
  tags = var.vnet_subnet.tags
}
