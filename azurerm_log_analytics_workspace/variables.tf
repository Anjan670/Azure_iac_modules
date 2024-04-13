variable "resource_group" {
  type        = string
  description = "Resource group name"
}
variable "log_analytics_workspace" {
  description = "log_analytics_workspace variables"
  type = map(object({
    name                               = string
    sku                                = string
    retention_in_days                  = optional(number)
    allow_resource_only_permissions    = optional(bool)
    local_authentication_disabled      = optional(bool)
    daily_quota_gb                     = optional(string)
    cmk_for_query_forced               = optional(string)
    internet_ingestion_enabled         = optional(bool)
    internet_query_enabled             = optional(bool)
    reservation_capacity_in_gb_per_day = optional(string) #The capacity reservation level in GB for this workspace. Possible values are 100, 200, 300, 400, 500, 1000, 2000 and 5000.
    data_collection_rule_id            = optional(string)
    tags                               = optional(string)
  }))
  default = {
    "one" = {
      name = "value02"
      sku = "PerGB2018"
    }
  }
}
