# Specify the required providers and their versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.50"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Azure Resource Manager Provider Configuration
# This block is used to configure the Azure Resource Manager (azurerm) provider, 
# which allows Terraform to create, update, and manage resources in Azure. 
# The `features` block is currently empty, which means it's using default configurations.
provider "azurerm" {
  features {}
}


# Terraform Configuration Block
# This block is used to configure Terraform behavior, including the backend. 
# No configuration is provided for the `local` backend, so it uses default settings.
terraform {
  backend "local" {
  }
}

# Local Values
# This block is used to define local, named values that can be used throughout the Terraform code. 
# `route_table_name` is the name of the default route table.
# `route_name` is the name of the route to Azure Firewall.
locals {
  route_table_name       = "DefaultRouteTable"
  route_name             = "RouteToAzureFirewall"
}

# Data source for getting the current Azure client configuration
# This data source is used to access the configuration of the currently authenticated Azure client. 
# It provides details like client ID, subscription ID, tenant ID, and others which can be used in other resources.
data "azurerm_client_config" "current" {
}

# Resource for creating an Azure Resource Group
# This resource is used to create a "hub" resource group in Azure. 
# A resource group is a container that holds related resources for an Azure solution. 
# The resource group can include all the resources for the solution, or only those resources that you want to manage as a group.
resource "azurerm_resource_group" "hub_rg" {
  name     = var.hub_resource_group_name
  location = var.location
  tags     = var.tags
}

# Resource for creating an Azure Resource Group
# This resource is used to create a "spoke" resource group in Azure. 
resource "azurerm_resource_group" "spoke_rg" {
  name     = var.spoke_resource_group_name
  location = var.spoke_location
  tags     = var.tags
}

# Module for creating a Log Analytics Workspace in Azure
# This module is responsible for creating a Log Analytics Workspace in Azure. 
# Log Analytics Workspace is a unique environment for Azure Monitor log data. 
# Each workspace has its own data repository and configuration, and data sources and solutions are configured to store their data in a workspace.
module "log_analytics_workspace" {
  source                           = "./modules/log_analytics"
  name                             = var.log_analytics_workspace_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.hub_rg.name
  solution_plan_map                = var.solution_plan_map
}

# Module for creating a Hub Network in Azure
# This module is responsible for creating a hub network in Azure. 
# A hub network is a design principle that allows you to manage and control 
# network traffic centrally. It typically contains shared services like VPN, firewall, and other security appliances.
module "hub_network" {
  source                       = "./modules/virtual_network"
  resource_group_name          = azurerm_resource_group.hub_rg.name
  location                     = var.location
  vnet_name                    = var.hub_vnet_name
  address_space                = var.hub_address_space
  tags                         = var.tags
  log_analytics_workspace_id   = module.log_analytics_workspace.id

  subnets = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : var.hub_firewall_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : "AzureBastionSubnet"
      address_prefixes : var.hub_bastion_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.vm_subnet_name
      address_prefixes : var.vm_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    }
  ]
}

# Module for creating a network for Azure Kubernetes Service (AKS)
# This module is responsible for creating a network in Azure for AKS. 
# The network is a critical part of AKS infrastructure as it provides the communication path for resources and services. 
# It includes components like virtual network, subnets, network security groups, and possibly more depending on the specific needs.
module "aks_network" {
  source                       = "./modules/virtual_network_spoke"
  resource_group_name          = azurerm_resource_group.spoke_rg.name
  location                     = var.spoke_location
  vnet_name                    = var.aks_vnet_name
  address_space                = var.aks_vnet_address_space
  log_analytics_workspace_id   = module.log_analytics_workspace.id

  subnets = [
    {
      name : var.default_node_pool_subnet_name
      address_prefixes : var.default_node_pool_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.additional_node_pool_subnet_name
      address_prefixes : var.additional_node_pool_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.pod_subnet_name
      address_prefixes : var.pod_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.pe_subnet_name
      address_prefixes : var.pe_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.lb_subnet_name
      address_prefixes : var.lb_subnet_address_prefix
      private_endpoint_network_policies_enabled : true
      private_link_service_network_policies_enabled : false
    }
  ]
}

# Module for creating a Virtual Network Peering in Azure
# This module is responsible for creating a virtual network peering in Azure. 
# Virtual network peering enables you to seamlessly connect two Azure virtual networks. 
# Once peered, the virtual networks appear as one, for connectivity purposes. 
# The traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, 
# much like traffic is routed between virtual machines in the same virtual network.
module "vnet_peering" {
  source              = "./modules/virtual_network_peering"
  vnet_1_name         = var.hub_vnet_name
  vnet_1_id           = module.hub_network.vnet_id
  vnet_1_rg           = azurerm_resource_group.hub_rg.name
  vnet_2_name         = var.aks_vnet_name
  vnet_2_id           = module.aks_network.vnet_id
  vnet_2_rg           = azurerm_resource_group.spoke_rg.name
  peering_name_1_to_2 = "${var.hub_vnet_name}To${var.aks_vnet_name}"
  peering_name_2_to_1 = "${var.aks_vnet_name}To${var.hub_vnet_name}"
  depends_on          = [module.hub_network, module.aks_network]
}


# Module for creating a Firewall in Azure
# This module is responsible for creating a firewall in Azure. 
# Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. 
# It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.
module "firewall" {
  source                       = "./modules/firewall"
  name                         = var.firewall_name
  resource_group_name          = azurerm_resource_group.hub_rg.name
  zones                        = var.firewall_zones
  threat_intel_mode            = var.firewall_threat_intel_mode
  location                     = var.location
  sku_name                     = var.firewall_sku_name 
  sku_tier                     = var.firewall_sku_tier
  pip_name                     = "${var.firewall_name}PublicIp"
  subnet_id                    = module.hub_network.subnet_ids["AzureFirewallSubnet"]
  log_analytics_workspace_id   = module.log_analytics_workspace.id
}


# Module for creating a Route Table in Azure
# This module is responsible for creating a Route Table in Azure. 
# A Route Table contains a set of rules, called routes, that are used to determine where network traffic is directed. 
# Each subnet in your VNet can be linked to a route table. 
# You can also change the routes in your Route Table to make your network traffic flow in a different path.
module "routetable" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.spoke_rg.name
  location             = var.spoke_location
  route_table_name     = local.route_table_name
  route_name           = local.route_name
  firewall_private_ip  = module.firewall.private_ip_address
  subnets_to_associate = {
    (var.default_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.spoke_rg.name
      virtual_network_name = module.aks_network.name
    }
    (var.additional_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.spoke_rg.name
      virtual_network_name = module.aks_network.name
    }
  }
}


# Module for creating an Azure Container Registry (ACR)
# This module is responsible for creating an ACR in Azure, which is a managed Docker registry service 
# used for storing and managing your private Docker container images and related components. 
# It's used to build, store, and manage images for all types of container deployments.
module "container_registry" {
  source                       = "./modules/container_registry"
  name                         = "${var.acr_name}${random_string.resource_suffix.result}"
  resource_group_name          = azurerm_resource_group.spoke_rg.name
  location                     = var.location
  sku                          = var.acr_sku
  admin_enabled                = var.acr_admin_enabled
  georeplication_locations     = var.acr_georeplication_locations
  log_analytics_workspace_id   = module.log_analytics_workspace.id
}


# Module for creating an Azure Kubernetes Service (AKS) cluster
# This module is responsible for creating an AKS cluster in Azure. 
# AKS is a managed container orchestration service provided by Azure for simplifying the deployment, 
# scaling, and operations of containerized applications.
module "aks_cluster" {
  source                                   = "./modules/aks"
  name                                     = var.aks_cluster_name
  location                                 = var.spoke_location
  resource_group_name                      = azurerm_resource_group.spoke_rg.name
  resource_group_id                        = azurerm_resource_group.spoke_rg.id
  kubernetes_version                       = var.kubernetes_version
  dns_prefix                               = lower(var.aks_cluster_name)
  private_cluster_enabled                  = var.private_cluster_enabled
  automatic_channel_upgrade                = var.automatic_channel_upgrade
  sku_tier                                 = var.aks_sku_tier
  default_node_pool_name                   = var.default_node_pool_name
  default_node_pool_vm_size                = var.default_node_pool_vm_size
  vnet_subnet_id                           = module.aks_network.subnet_ids[var.default_node_pool_subnet_name]
  private_dns_zone_name                    = "privatelink.${var.spoke_location}.azmk8s.io"
  hub_resource_group_name                  = var.hub_resource_group_name
  vnet_name                                = var.hub_vnet_name
  default_node_pool_availability_zones     = var.default_node_pool_availability_zones
  default_node_pool_node_labels            = var.default_node_pool_node_labels
  default_node_pool_node_taints            = var.default_node_pool_node_taints
  default_node_pool_enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
  default_node_pool_enable_host_encryption = var.default_node_pool_enable_host_encryption
  default_node_pool_enable_node_public_ip  = var.default_node_pool_enable_node_public_ip
  default_node_pool_max_pods               = var.default_node_pool_max_pods
  default_node_pool_max_count              = var.default_node_pool_max_count
  default_node_pool_min_count              = var.default_node_pool_min_count
  default_node_pool_node_count             = var.default_node_pool_node_count
  default_node_pool_os_disk_type           = var.default_node_pool_os_disk_type
  tags                                     = var.tags
  network_dns_service_ip                   = var.network_dns_service_ip
  network_plugin                           = var.network_plugin
  outbound_type                            = var.aks_outbound_type
  network_service_cidr                     = var.network_service_cidr
  log_analytics_workspace_id               = module.log_analytics_workspace.id
  role_based_access_control_enabled        = var.role_based_access_control_enabled
  tenant_id                                = data.azurerm_client_config.current.tenant_id
  admin_group_object_ids                   = var.admin_group_object_ids
  azure_rbac_enabled                       = var.azure_rbac_enabled
  admin_username                           = var.admin_username
  ssh_public_key                           = var.ssh_public_key
  keda_enabled                             = var.keda_enabled
  vertical_pod_autoscaler_enabled          = var.vertical_pod_autoscaler_enabled
  workload_identity_enabled                = var.workload_identity_enabled
  oidc_issuer_enabled                      = var.oidc_issuer_enabled
  open_service_mesh_enabled                = var.open_service_mesh_enabled
  image_cleaner_enabled                    = var.image_cleaner_enabled
  azure_policy_enabled                     = var.azure_policy_enabled
  http_application_routing_enabled         = var.http_application_routing_enabled

  depends_on                               = [module.routetable]
}


# Resources for creating a Azure Role Assignment
# This resource is used to assign a specific role to a principal (such as a user, group, or service principal). 
# In this case, the "Network Contributor" role is being assigned, which allows the principal to manage 
# all networking resources in Azure.
resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_resource_group.spoke_rg.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks_cluster.aks_identity_principal_id
  skip_service_principal_aad_check = true
}


# Resource for creating an Azure Role Assignment
# This resource is used to assign the "AcrPull" role to a principal. 
# The "AcrPull" role allows the principal to pull container images from an Azure Container Registry (ACR).
resource "azurerm_role_assignment" "acr_pull" {
  role_definition_name = "AcrPull"
  scope                = module.container_registry.id
  principal_id         = module.aks_cluster.kubelet_identity_object_id
  skip_service_principal_aad_check = true
}


# Generate randon name for resources that need unique names
# Not fool proof, but good enough for this example.
resource "random_string" "resource_suffix" {
  length  = 4
  special = false
  lower   = true
  upper   = false
  numeric  = false
}


# Module for creating an Azure Bastion Host
# This module is responsible for creating an Azure Bastion Host, which provides secure and seamless 
# Remote Desktop Protocol (RDP) and Secure Shell (SSH) access to your virtual machines directly in the 
# Azure portal over Secure Sockets Layer (SSL). This significantly reduces exposure to the public internet 
# and eliminates the need of a public IP address or a VPN connection.
module "bastion_host" {
  source                       = "./modules/bastion_host"
  name                         = var.bastion_host_name
  location                     = var.location
  resource_group_name          = azurerm_resource_group.hub_rg.name
  subnet_id                    = module.hub_network.subnet_ids["AzureBastionSubnet"]
  log_analytics_workspace_id   = module.log_analytics_workspace.id
}


# Module for creating an Azure Virtual Machine
# This module is responsible for creating a virtual machine in Azure. 
# A virtual machine provides an environment with an operating system, tools, and utilities just like a physical computer. 
# You can use it to run applications, install additional software, and configure an environment for your specific needs.
module "virtual_machine" {
  source                              = "./modules/virtual_machine"
  name                                = var.vm_name
  size                                = var.vm_size
  location                            = var.location
  public_ip                           = var.vm_public_ip
  vm_user                             = var.admin_username
  admin_ssh_public_key                = var.ssh_public_key
  os_disk_image                       = var.vm_os_disk_image
  domain_name_label                   = var.domain_name_label
  resource_group_name                 = azurerm_resource_group.hub_rg.name
  subnet_id                           = module.hub_network.subnet_ids[var.vm_subnet_name]
  log_analytics_workspace_id          = module.log_analytics_workspace.workspace_id
  log_analytics_workspace_key         = module.log_analytics_workspace.primary_shared_key
  log_analytics_workspace_resource_id = module.log_analytics_workspace.id
}


# Module for creating a Node Pool in Azure Kubernetes Service (AKS)
# This module is responsible for creating a node pool in an AKS cluster. 
# A node pool is a group of nodes with the same configuration. Node pools allow you to create dedicated pools 
# of nodes within your AKS cluster that have specific configurations. This is useful for workloads that require 
# specific hardware or software configurations.
module "node_pool" {
  source = "./modules/node_pool"
  kubernetes_cluster_id = module.aks_cluster.id
  name                         = var.additional_node_pool_name
  vm_size                      = var.additional_node_pool_vm_size
  mode                         = var.additional_node_pool_mode
  node_labels                  = var.additional_node_pool_node_labels
  node_taints                  = var.additional_node_pool_node_taints
  availability_zones           = var.additional_node_pool_availability_zones
  vnet_subnet_id               = module.aks_network.subnet_ids[var.additional_node_pool_subnet_name]
  enable_auto_scaling          = var.additional_node_pool_enable_auto_scaling
  enable_host_encryption       = var.additional_node_pool_enable_host_encryption
  enable_node_public_ip        = var.additional_node_pool_enable_node_public_ip
  orchestrator_version         = var.kubernetes_version
  max_pods                     = var.additional_node_pool_max_pods
  max_count                    = var.additional_node_pool_max_count
  min_count                    = var.additional_node_pool_min_count
  node_count                   = var.additional_node_pool_node_count
  os_type                      = var.additional_node_pool_os_type
  priority                     = var.additional_node_pool_priority
  tags                         = var.tags

  depends_on                   = [module.routetable]
}


# Module for creating an Azure Key Vault
# This module is responsible for creating a Key Vault in Azure. 
# Azure Key Vault is a service for securely storing and accessing secrets. 
# A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates. 
# Key Vault service can store and manage these secrets.
module "key_vault" {
  source                          = "./modules/key_vault"
  name                            = "${var.key_vault_name}${random_string.resource_suffix.result}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.spoke_rg.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_name
  tags                            = var.tags
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
  purge_protection_enabled        = var.key_vault_purge_protection_enabled
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  bypass                          = var.key_vault_bypass
  default_action                  = var.key_vault_default_action
  log_analytics_workspace_id      = module.log_analytics_workspace.id
}


# Module for creating a Private DNS Zone for Azure Container Registry (ACR)
# This module is responsible for creating a private DNS zone in Azure. 
# A private DNS zone provides name resolution for virtual machines within a virtual network and between virtual networks. 
# Additionally, you can configure zones names to match the private domain, and even split DNS scenarios are possible.
module "acr_private_dns_zone" {
  source                       = "./modules/private_dns_zone"
  name                         = "privatelink.azurecr.io"
  resource_group_name          = azurerm_resource_group.spoke_rg.name
  virtual_networks_to_link     = {
    (module.hub_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = azurerm_resource_group.hub_rg.name
    }
    (module.aks_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = azurerm_resource_group.spoke_rg.name
    }
  }
}


# Module for creating a Private DNS Zone for Azure Key Vault
# This module is responsible for creating a private DNS zone for Azure Key Vault in Azure. 
# A private DNS zone provides name resolution for virtual machines within a virtual network and between virtual networks. 
# Additionally, you can configure zones names to match the private domain, and even split DNS scenarios are possible.
module "key_vault_private_dns_zone" {
  source                       = "./modules/private_dns_zone"
  name                         = "privatelink.vaultcore.azure.net"
  resource_group_name          = azurerm_resource_group.spoke_rg.name
  virtual_networks_to_link     = {
    (module.hub_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = azurerm_resource_group.hub_rg.name
    }
    (module.aks_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = azurerm_resource_group.spoke_rg.name
    }
  }
}


# Module for creating a Private Endpoint for Azure Container Registry (ACR)
# This module is responsible for creating a private endpoint in Azure. 
# A private endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. 
# Private Endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. 
# All traffic to the service can be routed through the private endpoint, so no gateways, NAT devices, 
# ExpressRoute or VPN connections, or public IP addresses are needed.
module "acr_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${module.container_registry.name}PrivateEndpoint"
  location                       = var.spoke_location
  resource_group_name            = azurerm_resource_group.spoke_rg.name
  subnet_id                      = module.aks_network.subnet_ids[var.pe_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = module.container_registry.id
  is_manual_connection           = false
  subresource_name               = "registry"
  private_dns_zone_group_name    = "AcrPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.acr_private_dns_zone.id]
}


# Module for creating a Private Endpoint for Azure Key Vault
# This module is responsible for creating a private endpoint for Azure Key Vault in Azure. 
# A private endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. 
# Private Endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. 
# All traffic to the service can be routed through the private endpoint, so no gateways, NAT devices, 
# ExpressRoute or VPN connections, or public IP addresses are needed.
module "key_vault_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${title(module.key_vault.name)}PrivateEndpoint"
  location                       = var.spoke_location
  resource_group_name            = azurerm_resource_group.spoke_rg.name
  subnet_id                      = module.aks_network.subnet_ids[var.pe_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = module.key_vault.id
  is_manual_connection           = false
  subresource_name               = "vault"
  private_dns_zone_group_name    = "KeyVaultPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.key_vault_private_dns_zone.id]
}
