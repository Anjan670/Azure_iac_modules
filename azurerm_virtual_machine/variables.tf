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
}