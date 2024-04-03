# This file contains the terraform configuration to create an AKS cluster with the following features:
terraform {
  # Specifies the required providers and their source
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  # Specifies the required version of Terraform
  required_version = ">= 0.14.9"
}

# Creates a user assigned identity for the AKS cluster
resource "azurerm_user_assigned_identity" "aks_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.name}Identity"

  lifecycle {
    # Ignores changes to tags after the resource is created
    ignore_changes = [
      tags
    ]
  }
}

# Fetches data about the virtual network
data "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name
  resource_group_name = var.hub_resource_group_name
}

# Creates a private DNS zone
resource "azurerm_private_dns_zone" "aks_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

# Links the private DNS zone to the virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "aks_virtual_network_link" {
  name                  = "aks_virtual_network_link_to_hub"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id
}

# Creates the AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  kubernetes_version               = var.kubernetes_version
  dns_prefix                       = var.dns_prefix
  private_cluster_enabled          = var.private_cluster_enabled
  private_dns_zone_id              = azurerm_private_dns_zone.aks_dns_zone.id
  automatic_channel_upgrade        = var.automatic_channel_upgrade
  sku_tier                         = var.sku_tier
  workload_identity_enabled        = var.workload_identity_enabled
  oidc_issuer_enabled              = var.oidc_issuer_enabled
  open_service_mesh_enabled        = var.open_service_mesh_enabled
  image_cleaner_enabled            = var.image_cleaner_enabled
  azure_policy_enabled             = var.azure_policy_enabled
  http_application_routing_enabled = var.http_application_routing_enabled

  # Configures the default node pool
  default_node_pool {
    name                    = var.default_node_pool_name
    vm_size                 = var.default_node_pool_vm_size
    vnet_subnet_id          = var.vnet_subnet_id
    pod_subnet_id           = var.pod_subnet_id
    zones                   = var.default_node_pool_availability_zones
    node_labels             = var.default_node_pool_node_labels
    node_taints             = var.default_node_pool_node_taints
    enable_auto_scaling     = var.default_node_pool_enable_auto_scaling
    enable_host_encryption  = var.default_node_pool_enable_host_encryption
    enable_node_public_ip   = var.default_node_pool_enable_node_public_ip
    max_pods                = var.default_node_pool_max_pods
    max_count               = var.default_node_pool_max_count
    min_count               = var.default_node_pool_min_count
    node_count              = var.default_node_pool_node_count
    os_disk_type            = var.default_node_pool_os_disk_type
    tags                    = var.tags
  }

  # Configures the Linux profile
  linux_profile {
    admin_username = var.admin_username
    ssh_key {
        key_data = var.ssh_public_key
    }
  }

  # Configures the identity of the AKS cluster
  identity {
    type = "UserAssigned"
    identity_ids = tolist([azurerm_user_assigned_identity.aks_identity.id])
  }

  # Configures the network profile
  network_profile {
    dns_service_ip     = var.network_dns_service_ip
    network_plugin     = var.network_plugin
    outbound_type      = var.outbound_type
    service_cidr       = var.network_service_cidr
  }

  # Configures the OMS agent
  oms_agent {
    msi_auth_for_monitoring_enabled = true
    log_analytics_workspace_id      = coalesce(var.oms_agent.log_analytics_workspace_id, var.log_analytics_workspace_id)
  }

  # Configures Azure Active Directory role-based access control
  azure_active_directory_role_based_access_control {
    managed                    = true
    tenant_id                  = var.tenant_id
    admin_group_object_ids     = var.admin_group_object_ids
    azure_rbac_enabled         = var.azure_rbac_enabled
  }

  # Configures the workload autoscaler profile
  workload_autoscaler_profile {
    keda_enabled                    = var.keda_enabled
    vertical_pod_autoscaler_enabled = var.vertical_pod_autoscaler_enabled
  }

  lifecycle {
    # Ignores changes to kubernetes_version and tags after the resource is created
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }
}

# Configures the monitor diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_kubernetes_cluster.aks_cluster.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Enables logs for various categories
  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "guard"
  }

  # Enables all metrics
  metric {
    category = "AllMetrics"
  }
}