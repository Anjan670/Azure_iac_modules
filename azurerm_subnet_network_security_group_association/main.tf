data "azurerm_resource_group" "rgname" {
  name = var.common_all["Resource_group_name"]
}
data "azurerm_network_security_group" "nsgname" {
  name                = var.common_all["Network_security_group_name"]
  resource_group_name = data.azurerm_resource_group.rgname
}
data "azurerm_virtual_network" "vnet_subnet" {
  name                = var.common_all["Virtual_network_name"]
  resource_group_name = data.azurerm_resource_group.rgname.name
}
data "azurerm_subnet" "snet" {
  name                 = var.common_all["Subnet_name"]
  resource_group_name  = data.azurerm_resource_group.rgname.name
  virtual_network_name = var.common_all["Virtual_network_name"]
}
locals {
  subnet = (length(data.azurerm_subnet.snet.id) == 0) || (length(data.azurerm_virtual_network.vnet_subnet.subnet_id[*]) == 0)
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = local.subnet
  network_security_group_id = data.azurerm_network_security_group.nsgname.id
}
