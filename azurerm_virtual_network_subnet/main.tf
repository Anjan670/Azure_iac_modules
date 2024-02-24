data "azurerm_resource_group" "rgname" {
  name = var.common
}
data "azurerm_network_security_group" "nsgname" {
  name                = var.common_nsg
  resource_group_name = var.common
}
locals {
  subnet_value = length(var.var_subnet) == null ? null : var.var_subnet
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.var_vnet_name
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name
  address_space       = [var.var_vnet_address_space]
  dns_servers         = [var.var_vnet_dns_servers]

  dynamic "subnet" {
    for_each = local.subnet_value
    content {
      name           = subnet.value["name"]
      address_prefix = subnet.value["address_prefix"]
      security_group = data.azurerm_network_security_group.nsgname.id
    }
  }
}
