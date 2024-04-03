// This block specifies the required providers and the minimum version of Terraform that can be used with this configuration.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

// This block creates a virtual network in Azure. It uses variables for the network's name, address space, location, resource group, and tags.
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  // This block is used to ignore changes to the tags, meaning Terraform won't try to recreate the resource if only the tags change.
  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

// This block creates one or more subnets within the virtual network. It uses a `for_each` loop to create a subnet for each item in the `var.subnets` variable.
resource "azurerm_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                                           = each.key
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = each.value.address_prefixes
  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled  = each.value.private_link_service_network_policies_enabled
}

// This block (currently commented out) would create a diagnostic setting for the virtual network. The setting would send VM protection alerts and all metrics to a Log Analytics workspace.
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