# This block specifies the required providers and version for the Terraform configuration.
# In this case, the Azure Resource Manager (azurerm) provider is required.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  # This line specifies the minimum required version of Terraform for this configuration.
  required_version = ">= 0.14.9"
}

# This resource block generates a random string of 8 characters.
# The string will contain lower case letters and numbers, but no upper case letters or special characters.
resource "random_string" "script" {
  length = 8
  upper = false
  numeric = true
  lower = true
  special = false
}

# This resource block creates an Azure storage account.
resource "azurerm_storage_account" "storage_account" {
  # These lines specify the name and resource group for the storage account.
  name                = var.name
  resource_group_name = var.resource_group_name

  # These lines specify the location, kind, tier, replication type, and Hierarchical Namespace (HNS) status for the storage account.
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  is_hns_enabled           = var.is_hns_enabled
  tags                     = var.tags

  # This block defines the network rules for the storage account.
  network_rules {
    # This line sets the default action based on the lengths of the ip_rules and virtual_network_subnet_ids variables.
    default_action             = (length(var.ip_rules) + length(var.virtual_network_subnet_ids)) > 0 ? "Deny" : var.default_action
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  # This block sets the identity type for the storage account to "SystemAssigned".
  identity {
    type = "SystemAssigned"
  }

  # This block specifies that changes to the tags should be ignored during lifecycle events.
  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}