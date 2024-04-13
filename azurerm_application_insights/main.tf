data "azurerm_resource_group" "rg" {
  name = var.resource_group
}
resource "azurerm_application_insights" "app_insights" {
  for_each                              = var.application_insights
  name                                  = each.value["name"]
  location                              = data.azurerm_resource_group.rg.location
  resource_group_name                   = data.azurerm_resource_group.rg.name
  application_type                      = each.value["application_type"]
  daily_data_cap_in_gb                  = each.value["daily_data_cap_in_gb"] == null ? null : each.value["daily_data_cap_in_gb"]                                   #optional
  daily_data_cap_notifications_disabled = each.value["daily_data_cap_notifications_disabled"] == null ? null : each.value["daily_data_cap_notifications_disabled"] #optional
  retention_in_days                     = each.value["retention_in_days"] == null ? null : each.value["retention_in_days"]                                         #optional
  sampling_percentage                   = each.value["sampling_percentage"] == null ? null : each.value["sampling_percentage"]                                     #optional
  disable_ip_masking                    = each.value["disable_ip_masking"] == null ? null : each.value["disable_ip_masking"]                                       #optional
  workspace_id                          = each.value["workspace_id"] == null ? null : each.value["workspace_id"]                                                   #optional
  local_authentication_disabled         = each.value["local_authentication_disabled"] == null ? null : each.value["local_authentication_disabled"]                 #optional
  internet_ingestion_enabled            = each.value["internet_ingestion_enabled"] == null ? null : each.value["internet_ingestion_enabled"]                       #optional
  internet_query_enabled                = each.value["internet_query_enabled"] == null ? null : each.value["internet_query_enabled"]                               #optional
  force_customer_storage_for_profiler   = each.value["force_customer_storage_for_profiler"] == null ? null : each.value["force_customer_storage_for_profiler"]     #(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to false
}
