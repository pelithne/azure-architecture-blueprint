// This block specifies the required providers and version for this Terraform configuration.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" // Specifies the Azure Resource Manager provider from HashiCorp.
    }
  }

  required_version = ">= 0.14.9" // Specifies that this configuration requires at least Terraform version 0.14.9.
}

// This block is commented out. If uncommented, it would create a diagnostic setting for a resource.
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                           = var.name // Specifies the name of the diagnostic setting.
  target_resource_id             = var.target_resource_id // Specifies the ID of the resource for which to create the diagnostic setting.

  log_analytics_workspace_id     = var.log_analytics_workspace_id // Specifies the ID of the Log Analytics workspace to which to send the diagnostic data.
  log_analytics_destination_type = var.log_analytics_destination_type // Specifies the destination type for the Log Analytics data.

  eventhub_name                  = var.eventhub_name // Specifies the name of the Event Hub to which to send the diagnostic data.
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id // Specifies the ID of the authorization rule for the Event Hub.

  storage_account_id             = var.storage_account_id // Specifies the ID of the storage account to which to send the diagnostic data.

  // This block enables logging for specified categories.
  dynamic "enabled_log" {
    for_each = toset(logs) // Specifies the categories for which to enable logging.

    content {
      category = each.key // Specifies the category for this log.
    }
  }

  // This block enables all specified metrics.
  dynamic "metric" {
    for_each = toset(metrics) // Specifies the categories for which to enable metrics.

    content {
      category = each.key // Specifies the category for this metric.
      enabled  = true // Specifies that this metric is enabled.
    }
  }
}
*/