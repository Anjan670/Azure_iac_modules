variable "resource_group" {
  type        = string
  description = "Resource group name"
}
variable "application_insights" {
  description = "application_insights details"
  type = map(object({
    name                                  = string
    application_type                      = string
    daily_data_cap_in_gb                  = optional(string)
    daily_data_cap_notifications_disabled = optional(string)
    retention_in_days                     = optional(string)
    sampling_percentage                   = optional(string)
    disable_ip_masking                    = optional(string)
    workspace_id                          = optional(string)
    local_authentication_disabled         = optional(string)
    internet_ingestion_enabled            = optional(string)
    internet_query_enabled                = optional(string)
    force_customer_storage_for_profiler   = optional(bool)#(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to false 
  }))
  default = {
    "one" = {
      name = "name01"
      application_type = "web"
    }
  }
}
