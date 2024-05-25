resource "azurerm_resource_group" "rg" {
  name     = var.rg_var["name"]
  location = var.rg_var["location"]
}
