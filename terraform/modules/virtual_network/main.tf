// This block specifies the required providers and version for the Terraform configuration.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

// This block creates a virtual network resource.
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  // This block specifies that changes to the 'tags' attribute should be ignored during lifecycle operations.
  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

// This block creates a subnet resource for each subnet specified in the 'subnets' variable.
resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                                           = each.key
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = each.value.address_prefixes
  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled  = each.value.private_link_service_network_policies_enabled
}

// The following block is commented out. If uncommented, it would create a diagnostic setting resource for the virtual network.
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "VMProtectionAlerts"
  }

  metric {
    category = "AllMetrics"
  }
}
*/