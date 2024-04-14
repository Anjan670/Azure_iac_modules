variable "resource_group" {
  type        = string
  description = "Resource group name"
  default = "rg-02"
}
variable "log_analytics_workspace" {
  description = "log_analytics_workspace variables"
  type = map(object({
    name                               = string
    sku                                = string
    retention_in_days                  = optional(number)
    daily_quota_gb                     = optional(string)
    internet_ingestion_enabled         = optional(bool)
    internet_query_enabled             = optional(bool)
    reservation_capacity_in_gb_per_day = optional(string) #The capacity reservation level in GB for this workspace. Possible values are 100, 200, 300, 400, 500, 1000, 2000 and 5000.
  }))
  default = {
    "one" = {
      name = "value02"
      sku = "PerGB2018"
    }
  }
}
