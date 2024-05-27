data "azurerm_virtual_network" "vnet01" {
  name                = var.common_all_vnet_peering["Virtual_network_name01"]
  resource_group_name = var.common_all_vnet_peering["Virtual_network_name01"].resource_group_name
}
data "azurerm_virtual_network" "vnet02" {
  name                = var.common_all_vnet_peering["Virtual_network_name02"]
  resource_group_name = var.common_all_vnet_peering["Virtual_network_name02"].resource_group_name
}
resource "azurerm_virtual_network_peering" "vnet-1" {
  name                      = "peer1to2"
  resource_group_name       = data.azurerm_virtual_network.vnet01.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.vnet01.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet01.id
}
resource "azurerm_virtual_network_peering" "vnet-2" {
  name                      = "peer2to1"
  resource_group_name       = data.azurerm_virtual_network.vnet02.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.vnet02.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet02.id
}
