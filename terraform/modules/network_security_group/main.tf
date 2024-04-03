// The 'terraform' block is used to configure Terraform settings
terraform {
  // The 'required_providers' block is used to specify the providers required for this configuration
  required_providers {
    // The 'azurerm' block specifies the Azure Resource Manager provider
    azurerm = {
      // The 'source' attribute specifies the source of the provider
      source  = "hashicorp/azurerm"
    }
  }

  // The 'required_version' attribute specifies the required version of Terraform for this configuration
  required_version = ">= 0.14.9"
}

// The 'resource' block defines a resource of type 'azurerm_network_security_group'
resource "azurerm_network_security_group" "nsg" {
  // The 'name' attribute specifies the name of the network security group
  name                = var.name
  // The 'resource_group_name' attribute specifies the name of the resource group
  resource_group_name = var.resource_group_name
  // The 'location' attribute specifies the location of the network security group
  location            = var.location
  // The 'tags' attribute specifies the tags of the network security group
  tags                = var.tags

  // The 'dynamic' block is used to dynamically create 'security_rule' blocks
  dynamic "security_rule" {
    // The 'for_each' attribute specifies the collection to iterate over
    for_each = try(var.security_rules, [])
    // The 'content' block defines the content of the 'security_rule' block
    content {
      // The 'name' attribute specifies the name of the security rule
      name                                       = try(security_rule.value.name, null)
      // The 'priority' attribute specifies the priority of the security rule
      priority                                   = try(security_rule.value.priority, null)
      // The 'direction' attribute specifies the direction of the security rule
      direction                                  = try(security_rule.value.direction, null)
      // The 'access' attribute specifies the access of the security rule
      access                                     = try(security_rule.value.access, null)
      // The 'protocol' attribute specifies the protocol of the security rule
      protocol                                   = try(security_rule.value.protocol, null)
      // The 'source_port_range' attribute specifies the source port range of the security rule
      source_port_range                          = try(security_rule.value.source_port_range, null)
      // The 'source_port_ranges' attribute specifies the source port ranges of the security rule
      source_port_ranges                         = try(security_rule.value.source_port_ranges, null)
      // The 'destination_port_range' attribute specifies the destination port range of the security rule
      destination_port_range                     = try(security_rule.value.destination_port_range, null)
      // The 'destination_port_ranges' attribute specifies the destination port ranges of the security rule
      destination_port_ranges                    = try(security_rule.value.destination_port_ranges, null)
      // The 'source_address_prefix' attribute specifies the source address prefix of the security rule
      source_address_prefix                      = try(security_rule.value.source_address_prefix, null)
      // The 'source_address_prefixes' attribute specifies the source address prefixes of the security rule
      source_address_prefixes                    = try(security_rule.value.source_address_prefixes, null)
      // The 'destination_address_prefix' attribute specifies the destination address prefix of the security rule
      destination_address_prefix                 = try(security_rule.value.destination_address_prefix, null)
      // The 'destination_address_prefixes' attribute specifies the destination address prefixes of the security rule
      destination_address_prefixes               = try(security_rule.value.destination_address_prefixes, null)
      // The 'source_application_security_group_ids' attribute specifies the source application security group ids of the security rule
      source_application_security_group_ids      = try(security_rule.value.source_application_security_group_ids, null)
      // The 'destination_application_security_group_ids' attribute specifies the destination application security group ids of the security rule
      destination_application_security_group_ids = try(security_rule.value.destination_application_security_group_ids, null)
    }
  }

  // The 'lifecycle' block is used to configure lifecycle settings
  lifecycle {
    // The 'ignore_changes' attribute specifies the attributes to ignore changes to
    ignore_changes = [
        tags
    ]
  }
}

// The 'resource' block defines a resource of type 'azurerm_monitor_diagnostic_setting'
// This block is currently commented out
/*
resource "azurerm_monitor_diagnostic_setting" "settings" {
  // The 'name' attribute specifies the name of the diagnostic setting
  name                       = "DiagnosticsSettings"
  // The 'target_resource_id' attribute specifies the id of the target resource
  target_resource_id         = azurerm_network_security_group.nsg.id
  // The 'log_analytics_workspace_id' attribute specifies the id of the log analytics workspace
  log_analytics_workspace_id = var.log_analytics_workspace_id

  // The 'enabled_log' block is used to enable logs
  enabled_log {
    // The 'category' attribute specifies the category of the log
    category = "NetworkSecurityGroupEvent"
  }

  // The 'enabled_log' block is used to enable logs
  enabled_log {
    // The 'category' attribute specifies the category of the log
    category = "NetworkSecurityGroupRuleCounter"
  }
}
*/