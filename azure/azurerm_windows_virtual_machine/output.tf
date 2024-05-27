output "vm_id" {
  value = [for vm in azurerm_windows_virtual_machine.win_vm : vm.id]
}
output "data_disk_id" {
  value = [for disk in azurerm_managed_disk.data_disk : disk.id]
}
