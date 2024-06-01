output "subnet_id" {
  value = [for item in azurerm_virtual_network.vnet.subnet[*] : item.id]
}
output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
