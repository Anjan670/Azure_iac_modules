data "azurerm_resource_group" "rg" {
  name = var.resource_group.name
}
resource "azurerm_log_analytics_workspace" "law" {
  for_each                           = var.log_analytics_workspace
  name                               = each.value["name"]
  location                           = data.azurerm_resource_group.rg.location
  resource_group_name                = data.azurerm_resource_group.rg.name
  sku                                = each.value["sku"]
  retention_in_days                  = each.value["retention_in_days"] == null ? null : each.value["retention_in_days"]
  allow_resource_only_permissions    = each.value["allow_resource_only_permissions"] == null ? null : each.value["allow_resource_only_permissions"]
  local_authentication_disabled      = each.value["local_authentication_disabled"] == null ? null : each.value["local_authentication_disabled"]
  daily_quota_gb                     = each.value["daily_quota_gb"] == null ? null : each.value["daily_quota_gb"]
  cmk_for_query_forced               = each.value["cmk_for_query_forced"] == null ? null : each.value["cmk_for_query_forced"]
  internet_ingestion_enabled         = each.value["internet_ingestion_enabled"] == null ? null : each.value["internet_ingestion_enabled"]
  internet_query_enabled             = each.value["internet_query_enabled"] == null ? null : each.value["internet_query_enabled"]
  reservation_capacity_in_gb_per_day = each.value["reservation_capacity_in_gb_per_day"] == null ? null : each.value["reservation_capacity_in_gb_per_day"]
  data_collection_rule_id            = each.value["data_collection_rule_id"] == null ? null : each.value["data_collection_rule_id"]
}
