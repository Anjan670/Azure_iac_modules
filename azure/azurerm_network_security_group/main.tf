data "azurerm_resource_group" "rgname" {
  name = var.common
}
resource "azurerm_network_security_group" "nsg" {
  name                = "${data.azurerm_resource_group.rgname.name}_nsg"
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name

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
}

