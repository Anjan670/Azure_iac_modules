#
variable "rg_name" {
  type        = string
  description = "Resource group name"
}
variable "azure_frontdoor" {
  type = map(object({
    name = string
    routing_rule = object({
      name               = string
      accepted_protocols = list(string)
      patterns_to_match  = string
      patterns_to_match  = string
      forwarding_configuration = object({
        forwarding_protocol = string
        backend_pool_name   = string
      })
    })
    backend_pool_load_balancing = map(object({
      name                            = string
      sample_size                     = string
      successful_samples_required     = string
      additional_latency_milliseconds = string
    }))
    backend_pool_health_probe = map(object({
      name                = string
      enabled             = string
      path                = string
      protocol            = string
      probe_method        = optional(list(string))
      interval_in_seconds = optional(number)
    }))
    backend_pool = object({
      name = string
      backend = map(object({
        host_header = string
        address     = string
        http_port   = number
        https_port  = number
      }))
      load_balancing_name = string
      health_probe_name   = string
    })
    frontend_endpoin = object({
      name      = string
      host_name = string
    })
  }))
}