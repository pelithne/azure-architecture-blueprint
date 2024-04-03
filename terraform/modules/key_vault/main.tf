# This block specifies the required providers and versions for the Terraform configuration.
terraform {
  required_providers {
    # The Azure Resource Manager (azurerm) provider is required.
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  # The minimum required version of Terraform for this configuration is 0.14.9.
  required_version = ">= 0.14.9"
}

# This block defines an Azure Key Vault resource.
resource "azurerm_key_vault" "key_vault" {
  # These lines set various properties of the Key Vault using variables.
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  tags                            = var.tags
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  
  # This block sets the timeout for deleting the Key Vault to 60 minutes.
  timeouts {
    delete = "60m"
  }

  # This block sets the network access control lists (ACLs) for the Key Vault.
  network_acls {
    bypass                     = var.bypass
    default_action             = var.default_action
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  # This block specifies that changes to the tags property should be ignored during lifecycle operations.
  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

# This block is commented out. If uncommented, it would define a diagnostic setting for monitoring the Key Vault.
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_key_vault.key_vault.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_log {
    category = "AzurePolicyEvaluationDetails"
  }

  metric {
    category = "AllMetrics"
  }
}
*/