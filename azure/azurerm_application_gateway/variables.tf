variable "common" {
  description = "value"
  type = object({
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string
  })
}
variable "public_ip" {
  description = "value"
  type = object({
    name              = string
    allocation_method = string
  })
}
variable "app_gateway" {
  description = ""
  type = map(object({
    name = string
    sku = object({
      name     = string
      tier     = string
      capacity = number
    })
    frontend_port = object({
      name = string
      port = number
    })
    frontend_ip_configuration = object({
      name                          = string
      private_ip_address            = string
      private_ip_address_allocation = string
    })
    backend_address_pool = object({
      name         = string
      ip_addresses = string
      fqdns        = optional(string)
    })
    probe = map(object({
      name                                      = string
      protocol                                  = string
      pick_host_name_from_backend_http_settings = string
      host                                      = string
      port                                      = string
      path                                      = string
      interval                                  = number
      timeout                                   = number
      unhealthy_threshold                       = number
      match = {
        name        = string
        status_code = string
      }
    }))
    trusted_root_certificate = object({
      name = string
      data = string
    })
    ssl_certificate = object({
      name = string
      data = string
    })
    backend_http_settings = map(object({
      name                  = string
      protocol              = string
      port                  = string
      cookie_based_affinity = string
      connection_draining = object({
        enabled           = bool
        drain_timeout_sec = string
      })
      trusted_root_certificate_names = string
      request_timeout                = string
      path                           = optional(string)
      probe_name                     = string
    }))
    http_listener = object({
      name                           = string
      frontend_ip_configuration_name = string
      protocol                       = string
      frontend_port_name             = string
      ssl_certificate_name           = string
      host_name                      = string
    })
    url_path_map = object({
      name                               = string
      default_backend_address_pool_name  = string
      default_backend_http_settings_name = string
      path_rule = map(object({
        name                       = string
        paths                      = string
        backend_address_pool_name  = string
        backend_http_settings_name = string
      }))
    })
    request_routing_rule = object({
      name                       = string
      priority                   = number
      rule_type                  = string
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
      url_path_map_name          = string
    })
  }))
  default = {
    "appgateway01" = {
      name = "appgateway01"
      sku = {
        name     = "standard_v2"
        tier     = "standard_v2"
        capacity = 2
      }
      frontend_port = {
        name = "port_80"
        port = 80
      }
      frontend_ip_configuration = {
        name                          = "frontend_ip_configuration"
        private_ip_address            = "10.1.0.10"
        private_ip_address_allocation = "static"
      }
      backend_address_pool = {
        name         = "backendpool"
        ip_addresses = "10.1.0.20"
      }
    }
  }
}
