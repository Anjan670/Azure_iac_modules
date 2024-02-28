#
variable "common_windowsVM" {
  description = "value"
  type = object({
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string
  })
}
variable "public_ip" {
  description = "value"
  type = optional(object({
    name              = string
    allocation_method = string
  }))
}
variable "virtualmachine" {
  description = ""
  type = map(object({
    name                             = string
    vm_size                          = string
    delete_os_disk_on_termination    = bool
    delete_data_disks_on_termination = bool
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storage_os_disk = object({
      name              = string
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
    os_profile = object({
      computer_name  = string
      admin_username = string
      admin_password = string
    })
    storage_data_disk = object({
      name              = string
      caching           = string
      create_option     = string
      disk_size_gb      = string
      lun               = number
      managed_disk_type = string
    })
  }))
}
