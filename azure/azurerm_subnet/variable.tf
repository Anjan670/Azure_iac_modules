variable "common" {
  type    = string
  default = "rg-01"
}
variable "common_vnet" {
  type    = string
  default = "vnet01"
}
/*variable "subnets" {
  type = map(object(
    {
      name                                           = string
      address_prefixes                               = list(string)          # (Required) The address prefixes to use for the subnet.
      private_endpoint_network_policies_enabled      = optional(bool, false) # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`.
      private_link_service_network_policies_enabled  = optional(bool, false) # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`.
      enforce_private_link_endpoint_network_policies = optional(bool, false)
      enforce_private_link_service_network_policies  = optional(bool, false)
      service_endpoints                              = optional(set(string)) # (Optional) The list of Service endpoints to associate with the subnet. Possible values include: `Microsoft.AzureActiveDirectory`, `Microsoft.AzureCosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage` and `Microsoft.Web`.
      service_endpoint_policy_ids                    = optional(set(string)) # (Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
      delegations = optional(list(
        object(
          {
            name = string # (Required) A name for this delegation.
            service_delegation = object({
              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.
              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.
            })
          }
        )
      ))
    }
  ))
  description = "Subnets to create"
  default = {
    "Subnet01" = {
      name             = "subnet01"
      address_prefixes = ["10.10.10.10/26"]
    }
  }
}*/
variable "subnet" {
  description = "Subnet to create"
  type = map(object({
    name                                          = string
    address_prefixes                              = string
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    delegation = optional(list(
      object({
        name = string
        service_delegation = object({
          name    = string
          actions = optional(list(string))
        })
      })
    ))
  }))
  default = {
    "subnet01" = {
      name             = "subnet01"
      address_prefixes = "10.10.10.10/24"
      # Other properties...
      /*delegation = [
        {
          name = "delegation1"
          service_delegation = {
            name    = "Microsoft.Network/virtualNetworks/subnets/action"
            actions = ["Microsoft.Network/networkinterfaces/*"]
          }
        },
        # Additional delegations if needed...
      ]*/
    },
    # Additional subnets if needed...
  }
}

