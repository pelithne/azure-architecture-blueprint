// This block specifies the required providers and their sources.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" // Specifies the source of the Azure provider.
    }
  }

  required_version = ">= 0.14.9" // Specifies the minimum required version of Terraform.
}

// This block creates a public IP address resource in Azure.
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name}PublicIp"   // The name of the public IP address.
  location            = var.location            // The location where the public IP address will be created.
  resource_group_name = var.resource_group_name // The name of the resource group in which to create the public IP address.
  allocation_method   = "Static"                // The allocation method for the public IP address. This is set to Static.
  sku                 = "Standard"              // The SKU of the public IP address. This is set to Standard.

  lifecycle {
      ignore_changes = [
          tags // This tells Terraform to ignore changes to tags after the resource is created.
      ]
  }
}

// This block creates a Bastion Host resource in Azure.
resource "azurerm_bastion_host" "bastion_host" {
  name                = var.name                // The name of the Bastion Host.
  location            = var.location            // The location where the Bastion Host will be created.
  resource_group_name = var.resource_group_name // The name of the resource group in which to create the Bastion Host.
  tags                = var.tags                // The tags to associate with the Bastion Host.

  ip_configuration {
    name                 = "configuration"                // The name of the IP configuration.
    subnet_id            = var.subnet_id                  // The ID of the subnet in which to create the Bastion Host.
    public_ip_address_id = azurerm_public_ip.public_ip.id // The ID of the public IP address to associate with the Bastion Host.
  }

  lifecycle {
      ignore_changes = [
          tags // This tells Terraform to ignore changes to tags after the resource is created.
      ]
  }
}

// The following blocks are commented out. If uncommented, they would create diagnostic settings for the Bastion Host and the public IP address.
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"                // The name of the diagnostic settings.
  target_resource_id         = azurerm_bastion_host.bastion_host.id // The ID of the resource to which the diagnostic settings apply.
  log_analytics_workspace_id = var.log_analytics_workspace_id       // The ID of the Log Analytics workspace to which the diagnostic data will be sent.

  enabled_log {
    category = "BastionAuditLogs" // Enables the collection of Bastion Audit Logs.
  }

  metric {
    category = "AllMetrics" // Enables the collection of all metrics.
  }
}


resource "azurerm_monitor_diagnostic_setting" "pip_settings" {
  name                       = "DiagnosticsSettings"          // The name of the diagnostic settings.
  target_resource_id         = azurerm_public_ip.public_ip.id // The ID of the resource to which the diagnostic settings apply.
  log_analytics_workspace_id = var.log_analytics_workspace_id // The ID of the Log Analytics workspace to which the diagnostic data will be sent.

  enabled_log {
    category = "DDoSProtectionNotifications" // Enables the collection of DDoS Protection Notifications.
  }

  enabled_log {
    category = "DDoSMitigationFlowLogs"     // Enables the collection of DDoS Mitigation Flow Logs.
  }

  enabled_log {
    category = "DDoSMitigationReports"      // Enables the collection of DDoS Mitigation Reports.
  }

  metric {
    category = "AllMetrics"                 // Enables the collection of all metrics.
  }
}
*/