output "vnet" {
  value = azurerm_virtual_network.vnet.id
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "snet" {
  value = azurerm_virtual_network.vnet.subnet[*].id
}
