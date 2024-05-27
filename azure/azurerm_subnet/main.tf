data "azurerm_resource_group" "rgname" {
  name = var.common
}
data "azurerm_virtual_network" "vnet_name" {
  name                = var.common_vnet
  resource_group_name = var.common
}
resource "azurerm_subnet" "subnet" {
  for_each                    = var.subnet
  name                        = each.value["name"]
  resource_group_name         = data.azurerm_resource_group.rgname.name
  virtual_network_name        = data.azurerm_virtual_network.vnet_name.name
  address_prefixes            = [each.value["address_prefixes"]]
  service_endpoints           = each.value["service_endpoints"]
  service_endpoint_policy_ids = each.value["service_endpoint_policy_ids"]
  dynamic "delegation" {
    for_each = can(each.value["delegation"]) && each.value["delegation"] != null ? each.value["delegation"] : []
    content {
      name = delegation.value["name"]
      dynamic "service_delegation" {
        for_each = can(delegation.value["service_delegation"]) && delegation.value["service_delegation"] != null ? [delegation.value["service_delegation"]] : []
        content {
          name    = service_delegation.value["name"]
          actions = can(service_delegation.value["actions"]) ? service_delegation.value["actions"] : []
        }
      }
    }
  }
}

