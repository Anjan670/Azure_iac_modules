output "lgw_id" {
  value = [ for lag in azurerm_log_analytics_workspace.law : lag.workspace_id ]
}