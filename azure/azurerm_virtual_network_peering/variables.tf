variable "common_all_vnet_peering" {
  description = "Vnet Peering vnet01 to vnet02 same vnet02 to vnet01"
  type = object({
    Virtual_network_name01 = string
    Virtual_network_name02 = string
  })
}