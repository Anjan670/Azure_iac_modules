#----------------------------------------------
# Note: 
#The azurerm_virtual_machine resource has been superseded by the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine resources. 
#The existing azurerm_virtual_machine resource will continue to be available throughout the 3.x releases however is in a feature-frozen state to maintain compatibility - new functionality will instead be added to the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine resources.
#----------------------------------------------
data "azurerm_resource_group" "rg" {
  name = var.common.resource_group_name
}
data "azurerm_virtual_network" "vnet" {
  name                = var.common.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
data "azurerm_subnet" "snet" {
  name                 = var.common.subnet_name
  virtual_network_name = var.common.virtual_network_name
  resource_group_name  = data.azurerm_resource_group.rg.name
}
resource "azurerm_public_ip" "public_ip" {
  for_each            = var.public_ip
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
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
  for_each                         = var.virtualmachine
  name                             = each.value["name"]
  location                         = data.azurerm_resource_group.rg.location
  resource_group_name              = data.azurerm_resource_group.rg.name
  network_interface_ids            = [for nic in output.nic_id : nic.id] #[azurerm_network_interface.nic.id]
  vm_size                          = each.value["vm_size"]
  delete_os_disk_on_termination    = each.value["delete_os_disk_on_termination"]
  delete_data_disks_on_termination = each.value["delete_data_disks_on_termination"]
  depends_on                       = [azurerm_network_interface.nic]
  dynamic "storage_image_reference" {
    for_each = var.virtualmachine.storage_image_reference
    content {
      publisher = storage_image_reference.value["publisher"]
      offer     = storage_image_reference.value["offer"]
      sku       = storage_image_reference.value["sku"]
      version   = storage_image_reference.value["version"]
    }
  }
  dynamic "storage_os_disk" {
    for_each = var.virtualmachine.storage_os_disk
    content {
      name              = storage_os_disk.value["name"]
      caching           = storage_os_disk.value["caching"]
      create_option     = storage_os_disk.value["create_option"]
      managed_disk_type = storage_os_disk.value["managed_data_type"]
    }
  }
  dynamic "os_profile" {
    for_each = var.virtualmachine.os_profile
    content {
      computer_name  = os_profile.value["computer_name"]
      admin_username = os_profile.value["admin_username"]
      admin_password = os_profile.value["admin_password"]
    }
  }
  dynamic "storage_data_disk" {
    for_each = var.virtualmachine.storage_data_disk
    content {
      name              = storage_data_disk.value["name"]
      caching           = storage_data_disk.value["caching"]
      create_option     = storage_data_disk.value["create_option"]
      disk_size_gb      = storage_data_disk.value["disk_size_gb"]
      lun               = storage_data_disk.value["lun"]
      managed_disk_type = storage_data_disk.value["managed_disk_type"]
    }
  }
}
