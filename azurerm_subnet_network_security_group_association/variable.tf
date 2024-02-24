variable "common" {
  type    = string
  default = "rg-01"
}
variable "common_nsg" {
  type    = string
  default = "nsg01"
}
variable "common_all" {
  type = object({
    Resource_group_name         = string
    Virtual_network_name        = string
    Subnet_name                 = string
    Network_security_group_name = string
  })
}
