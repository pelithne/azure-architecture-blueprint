// This block specifies the required providers and version for this Terraform configuration.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" // Specifies the Azure Resource Manager provider from HashiCorp.
    }
  }

  required_version = ">= 0.14.9" // Specifies that this configuration requires at least Terraform version 0.14.9.
}

// This block creates an Azure Container Registry (ACR) resource.
resource "azurerm_container_registry" "acr" {
  name                     = var.name // Specifies the name of the ACR.
  resource_group_name      = var.resource_group_name // Specifies the resource group in which to create the ACR.
  location                 = var.location // Specifies the location in which to create the ACR.
  sku                      = var.sku // Specifies the SKU of the ACR.
  admin_enabled            = var.admin_enabled // Specifies whether the admin account is enabled.
  tags                     = var.tags // Specifies the tags to associate with the ACR.

  // This block assigns a user-assigned managed identity to the ACR.
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id // Specifies the ID of the user-assigned managed identity.
    ]
  }

  // This block creates geo-replications for the ACR.
  dynamic "georeplications" {
    for_each = var.georeplication_locations // Specifies the locations for geo-replication.

    content {
      location = georeplications.value // Specifies the location for this geo-replication.
      tags     = var.tags // Specifies the tags to associate with this geo-replication.
    }
  }

  // This block specifies that changes to the tags should be ignored during subsequent updates.
  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

// This block creates a user-assigned managed identity resource.
resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = var.resource_group_name // Specifies the resource group in which to create the managed identity.
  location            = var.location // Specifies the location in which to create the managed identity.
  tags                = var.tags // Specifies the tags to associate with the managed identity.

  name = "${var.name}Identity" // Specifies the name of the managed identity.

  // This block specifies that changes to the tags should be ignored during subsequent updates.
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

// This block is commented out. If uncommented, it would create a diagnostic setting for the ACR.
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings" // Specifies the name of the diagnostic setting.
  target_resource_id         = azurerm_container_registry.acr.id // Specifies the ID of the ACR for which to create the diagnostic setting.
  log_analytics_workspace_id = var.log_analytics_workspace_id // Specifies the ID of the Log Analytics workspace to which to send the diagnostic data.

  // This block enables logging for repository events.
  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
  }

  // This block enables logging for login events.
  enabled_log {
    category = "ContainerRegistryLoginEvents"
  }

  // This block enables all metrics.
  metric {
    category = "AllMetrics"
  }
}
*/