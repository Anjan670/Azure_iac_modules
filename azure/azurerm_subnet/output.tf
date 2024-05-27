/*output "out_subnet" {
 value = azurerm_subnet.subnet[*].id
}*/
output "out_subnet" {
  value = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}
