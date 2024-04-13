output "instrumentation_key" {
  value = [ for ik in azurerm_application_insights.app_insights : ik.instrumentation_key]
  sensitive = true
}
output "app_id" {
  value = [ for apid in azurerm_application_insights.app_insights : apid.app_id ]
}