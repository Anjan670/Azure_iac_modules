output "rgname" {
  value = [for rg in azurerm_resource_group.rg : rg.name]
}
output "rglocation" {
  value = [for rg in azurerm_resource_group.rg : rg.location]
}
output "rgid" {
  value = [for rg in azurerm_resource_group.rg : rg.id]
}
