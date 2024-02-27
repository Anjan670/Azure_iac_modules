#----------------------------------------------
# Note: 
#The azurerm_virtual_machine resource has been superseded by the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine resources. 
#The existing azurerm_virtual_machine resource will continue to be available throughout the 3.x releases however is in a feature-frozen state to maintain compatibility - new functionality will instead be added to the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine resources.
#----------------------------------------------
data "azurerm_resource_group" "rg" {
  name     = ""
  location = ""
}
data "azurerm_virtual_network" "vnet" {
  name                = ""
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
data "azurerm_subnet" "snet" {
  name                 = ""
  virtual_network_name = ""
  resource_group_name  = data.azurerm_resource_group.rg.name
}
resource "azurerm_public_ip" "public_ip" {
  for_each            = var.public_ip
  name                = each.value["name"]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = each.value["allocation_method"]
}
resource "azurerm_network_interface" "nic" {
  for_each            = var.virtualmachine
  name                = "${each.value["name"]}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dynamic "ip_configuration" {
    for_each = var.virtualmachine.network_interface
    content {
      name                          = "internal"
      subnet_id                     = data.azurerm_subnet.snet.id
      public_ip_address_id          = var.public_ip == null ? null : azurerm_public_ip.public_ip.id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value["private_ip_address"]
      private_ip_address_version    = "IPv4"
    }

  }
}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.virtualmachine
  name                             = ""
  location                         = data.azurerm_resource_group.rg.location
  resource_group_name              = data.azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = ""
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = ""
    offer     = ""
    sku       = ""
    version   = ""
  }
  storage_os_disk {
    name              = ""
    caching           = ""
    create_option     = ""
    managed_disk_type = ""
  }
  os_profile {
    computer_name  = ""
    admin_username = ""
    admin_password = ""
  }
  storage_data_disk {
    name              = ""
    caching           = ""
    create_option     = ""
    disk_size_gb      = ""
    lun               = ""
    managed_disk_type = ""
  }
}
