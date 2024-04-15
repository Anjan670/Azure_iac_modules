variable "resource_group" {
  type        = string
  description = "Resource group name"
  default     = ""
}
variable "virtual_network" {
  type        = string
  description = "Virtual Network"
  default     = ""
}
variable "subnet" {
  type        = string
  description = "subnet details"
  default     = ""
}
variable "public_ip" {
  description = "value"
  type = object({
    name              = string
    allocation_method = string
    sku               = string
  })
}
variable "bastion_host_name" {
  description = "Bastion host details"
  type = string
  default = ""
}
