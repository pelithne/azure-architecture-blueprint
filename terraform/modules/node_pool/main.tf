// This block specifies the version and providers that Terraform will use to provision resources.
terraform {
  // The required_providers block specifies the providers required for this configuration.
  required_providers {
    // The azurerm provider is used to interact with resources supported by Azure Resource Manager.
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  // The required_version parameter specifies the version of Terraform required for this configuration.
  required_version = ">= 0.14.9"
}

// This block defines a resource of type "azurerm_kubernetes_cluster_node_pool".
resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  // The ID of the Kubernetes cluster.
  kubernetes_cluster_id        = var.kubernetes_cluster_id
  // The name of the node pool.
  name                         = var.name
  // The size of the Virtual Machine.
  vm_size                      = var.vm_size
  // The mode of the node pool.
  mode                         = var.mode
  // The labels to assign to nodes in the node pool.
  node_labels                  = var.node_labels
  // The taints to apply to nodes in the node pool.
  node_taints                  = var.node_taints
  // The availability zones in which to create the nodes.
  zones                        = var.availability_zones
  // The ID of the subnet in which to create the nodes.
  vnet_subnet_id               = var.vnet_subnet_id
  // The ID of the subnet in which to create the pods.
  pod_subnet_id                = var.pod_subnet_id
  // Whether to enable auto-scaling.
  enable_auto_scaling          = var.enable_auto_scaling
  // Whether to enable host encryption.
  enable_host_encryption       = var.enable_host_encryption
  // Whether to enable public IP on nodes.
  enable_node_public_ip        = var.enable_node_public_ip
  // The ID of the proximity placement group.
  proximity_placement_group_id = var.proximity_placement_group_id
  // The version of the orchestrator.
  orchestrator_version         = var.orchestrator_version
  // The maximum number of pods that can be run on a node.
  max_pods                     = var.max_pods
  // The maximum number of nodes in the node pool.
  max_count                    = var.max_count
  // The minimum number of nodes in the node pool.
  min_count                    = var.min_count
  // The number of nodes in the node pool.
  node_count                   = var.node_count
  // The size of the OS disk in GB.
  os_disk_size_gb              = var.os_disk_size_gb
  // The type of the OS disk.
  os_disk_type                 = var.os_disk_type
  // The type of the OS.
  os_type                      = var.os_type
  // The priority of the node pool.
  priority                     = var.priority
  // The tags to assign to the node pool.
  tags                         = var.tags

  // The lifecycle block.
  lifecycle {
    // The ignore_changes parameter is used to ignore changes to the specified properties.
    ignore_changes = [
        tags
    ]
  }
}