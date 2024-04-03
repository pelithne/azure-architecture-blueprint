// The 'terraform' block is used to specify Terraform settings, including the required providers and versions
terraform {
  // The 'required_providers' block specifies the providers required for this configuration
  required_providers {
    // The 'azurerm' block specifies the Azure Resource Manager provider settings
    azurerm = {
      // The 'source' attribute specifies the source of the provider
      source  = "hashicorp/azurerm"
    }
  }

  // The 'required_version' attribute specifies the required Terraform version for this configuration
  required_version = ">= 0.14.9"
}

// The 'locals' block is used to define local values that can be used throughout the configuration
locals {
  // The 'module_tag' local value is a map that contains the module name
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  // The 'tags' local value is a map that merges the 'tags' variable and the 'module_tag' local value
  tags = merge(var.tags, local.module_tag)
}

// The 'azurerm_log_analytics_workspace' resource block defines a Log Analytics workspace
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  // The 'name' attribute specifies the name of the Log Analytics workspace
  name                = var.name
  // The 'location' attribute specifies the location of the Log Analytics workspace
  location            = var.location
  // The 'resource_group_name' attribute specifies the resource group of the Log Analytics workspace
  resource_group_name = var.resource_group_name
  // The 'sku' attribute specifies the SKU of the Log Analytics workspace
  sku                 = var.sku
  // The 'tags' attribute specifies the tags of the Log Analytics workspace
  tags                = local.tags
  // The 'retention_in_days' attribute specifies the data retention in days
  retention_in_days   = var.retention_in_days != "" ? var.retention_in_days : null

  // The 'lifecycle' block is used to configure lifecycle settings
  lifecycle {
      // The 'ignore_changes' attribute specifies the attributes to ignore changes to
      ignore_changes = [
          tags
      ]
  }
}

// The 'azurerm_log_analytics_solution' resource block defines a Log Analytics solution
resource "azurerm_log_analytics_solution" "la_solution" {
  // The 'for_each' attribute specifies the map to iterate over
  for_each = var.solution_plan_map

  // The 'solution_name' attribute specifies the name of the solution
  solution_name         = each.key
  // The 'location' attribute specifies the location of the solution
  location              = var.location
  // The 'resource_group_name' attribute specifies the resource group of the solution
  resource_group_name   = var.resource_group_name
  // The 'workspace_resource_id' attribute specifies the resource ID of the workspace
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  // The 'workspace_name' attribute specifies the name of the workspace
  workspace_name        = azurerm_log_analytics_workspace.log_analytics_workspace.name

  // The 'plan' block specifies the plan settings
  plan {
    // The 'product' attribute specifies the product of the plan
    product   = each.value.product
    // The 'publisher' attribute specifies the publisher of the plan
    publisher = each.value.publisher
  }

  // The 'lifecycle' block is used to configure lifecycle settings
  lifecycle {
    // The 'ignore_changes' attribute specifies the attributes to ignore changes to
    ignore_changes = [
      tags
    ]
  }
}