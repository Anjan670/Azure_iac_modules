#
output "nic_id" {
  value = [for item in azurerm_network_interface.nic : item.id]
}