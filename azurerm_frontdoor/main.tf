data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
resource "azurerm_frontdoor" "example" {
  for_each            = var.azure_frontdoor
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.rg.name
  dynamic "routing_rule" {
    for_each = var.azure_frontdoor.routing_rule
    content {
      name               = routing_rule.value["name"]
      accepted_protocols = [routing_rule.value["accepted_protocols"]]
      patterns_to_match  = [routing_rule.value["patterns_to_match"]]
      frontend_endpoints = [routing_rule.value["frontend_endpoints"]]
      dynamic "forwarding_configuration" {
        for_each = var.azure_frontdoor.routing_rule.forwarding_configuration
        content {
          forwarding_protocol = forwarding_configuration.value["forwarding_protocol"]
          backend_pool_name   = forwarding_configuration.value["backend_pool_name"]
        }
      }
    }
  }
  dynamic "backend_pool_load_balancing" {
    for_each = var.azure_frontdoor.backend_pool_load_balancing
    content {
      name                            = backend_pool_load_balancing.value["name"]
      sample_size                     = backend_pool_load_balancing.value["sample_size"]
      successful_samples_required     = backend_pool_load_balancing.value["successful_samples_required"]
      additional_latency_milliseconds = backend_pool_load_balancing.value["additional_latency_milliseconds"]
    }
  }
  dynamic "backend_pool_health_probe" {
    for_each = var.azure_frontdoor.backend_pool_health_probe
    content {
      name                = backend_pool_health_probe.value["name"]
      enabled             = backend_pool_health_probe.value["enabled"]
      path                = backend_pool_health_probe.value["path"]
      protocol            = backend_pool_health_probe.value["protocol"]
      probe_method        = backend_pool_health_probe.value["probe_method"]
      interval_in_seconds = backend_pool_health_probe.value["interval_in_seconds"]
    }
  }
  backend_pool {
    name = each.value.backend_pool["name"]
    dynamic "backend" {
      for_each = var.azure_frontdoor.backend
      content {
        host_header = backend.value["host_header"]
        address     = backend.value["address"]
        http_port   = backend.value["http_port"]
        https_port  = backend.value["https_port"]
      }
    }
    load_balancing_name = each.value.backend_pool["load_balancing_name"]
    health_probe_name   = each.value.backend_pool["health_probe_name"]
  }
  dynamic "frontend_endpoint" {
    for_each = var.azure_frontdoor.frontend_endpoint
    content {
      name      = frontend_endpoint.value["name"]
      host_name = frontend_endpoint.value["host_name"]
    }

  }
}