data "azurerm_resource_group" "rg" {
  name = var.resource_group
}
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network
  resource_group_name = data.azurerm_resource_group.rg
}
data "azurerm_subnet" "snet" {
  name = var.subnet
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.rg.name
}
resource "azurerm_public_ip" "pip" {
  for_each            = var.public_ip
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = each.value["allocation_method"]
  sku                 = each.value["sku"]
}
resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_host_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.snet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}
