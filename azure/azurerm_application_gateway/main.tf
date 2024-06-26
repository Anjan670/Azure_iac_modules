data "azurerm_resource_group" "rg" {
  for_each = var.common
  name     = each.value["resource_group_name"]
}
data "azurerm_virtual_network" "vnet" {
  for_each            = var.common
  name                = each.value["virtual_network_name"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "snet" {
  for_each             = var.common
  name                 = each.value["subnet_name"]
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}
resource "azurerm_public_ip" "public_ip" {
  for_each            = var.public_ip
  name                = each.value["name"]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = each.value["allocation_method"]
}
resource "azurerm_application_gateway" "appgateway" {
  for_each            = var.app_gateway
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku {
    name     = each.value.sku["name"]
    tier     = each.value.sku["tier"]
    capacity = each.value.sku["capacity"]
  }
  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration["name"]
    subnet_id = data.azurerm_subnet.snet.id
  }
  frontend_port {
    name = each.value.frontend_port["name"]
    port = each.value.frontend_port["port"]
  }
  frontend_ip_configuration {
    name                          = each.value.frontend_ip_configuration["name"]
    public_ip_address_id          = azurerm_public_ip.publi_ip.id
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address            = each.value.frontend_ip_configuration["private_ip_address"]
    private_ip_address_allocation = each.value.frontend_ip_configuration["private_ip_address_allocation"]
  }
  backend_address_pool {
    name         = each.value.backend_address_pool["name"]
    ip_addresses = each.value.backend_address_pool["ip_addresses"]
    fqdns        = each.value.backend_address_pool["fqdns"] == null ? null : each.value.backend_address_pool["fqdns"]
  }
  dynamic "probe" {
    for_each = var.app_gateway.probe
    content {
      name                                      = probe.value["name"]
      protocol                                  = probe.value["protocol"]
      pick_host_name_from_backend_http_settings = probe.value["pick_host_name_from_backend_http_settings"]
      host                                      = probe.value["host"]
      port                                      = probe.value["port"]
      path                                      = probe.value["path"]
      interval                                  = probe.value["interval"]
      timeout                                   = probe.value["timeout"]
      unhealthy_threshold                       = probe.value["unhealthy_threshold"]
      dynamic "match" {
        for_each = probe.value.match
        content {
          body        = match.value["body"]
          status_code = match.value["status_code"]
        }
      }
    }
  }
  trusted_root_certificate {
    name = ""
    data = filebase64("${(path.module) / RootCert.cer}")
  }
  ssl_certificate {
    name     = ""
    data     = filebase64("${(path.module) / RootCert.cer}")
    password = ""
  }
  dynamic "backend_http_settings" {
    for_each = var.app_gateway.backend_http_settings
    content {
      name                  = backend_http_settings.value["name"]
      protocol              = backend_http_settings.value["protocol"]
      port                  = backend_http_settings.value["port"]
      cookie_based_affinity = backend_http_settings.value["cookie_based_affinity"]
      dynamic "connection_draining" {
        for_each = backend_address_pool.value.connection_draining
        content {
          enabled           = connection_draining.value["enabled"]
          drain_timeout_sec = connection_draining.value["drain_timeout_sec"]
        }
      }
      trusted_root_certificate_names = backend_http_settings.value["trusted_root_certificate_names"]
      request_timeout                = backend_http_settings.value["request_timeout"]
      path                           = backend_http_settings.value["path"] == null ? null : backend_http_settings.value["path"]
      probe_name                     = backend_http_settings.value["probe_name"]
    }
  }
  http_listener {
    name                           = each.value.http_listener["name"]
    frontend_ip_configuration_name = each.value.http_listener["frontend_ip_configuration_name"]
    protocol                       = each.value.http_listener["protocol"]
    frontend_port_name             = each.value.http_listener["frontend_port_name"]
    ssl_certificate_name           = each.value.http_listener["ssl_certificate_name"]
    host_name                      = each.value.http_listener["host_name"]
  }
  url_path_map {
    name                               = each.value.url_path_map["name"]
    default_backend_address_pool_name  = each.value.url_path_map["default_backend_address_pool_name"]
    default_backend_http_settings_name = each.value.url_path_map["default_backend_http_settings_name"]
    dynamic "path_rule" {
      for_each = url_path_map.value.path_rule
      content {
        name                       = path_rule.value["name"]
        paths                      = path_rule.value["paths"]
        backend_address_pool_name  = path_rule.value["backend_address_pool_name"]
        backend_http_settings_name = path_rule.value["backend_http_settings_name"]
      }
    }
  }
  request_routing_rule {
    name                       = each.value.request_routing_rule["name"]
    priority                   = each.value.request_routing_rule["priority"]
    rule_type                  = each.value.request_routing_rule["rule_type"]
    http_listener_name         = each.value.request_routing_rule["http_listener_name "]
    backend_address_pool_name  = each.value.request_routing_rule["backend_address_pool_name"]
    backend_http_settings_name = each.value.request_routing_rule["backend_http_settings_name"]
    url_path_map_name          = each.value.request_routing_rule["url_path_map_name"]
  }
}
