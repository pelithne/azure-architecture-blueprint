# This block specifies the required providers for this Terraform configuration.
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

# This block defines a resource of type "azurerm_private_dns_zone".
# This resource represents a private DNS zone in Azure.
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  # This block specifies that changes to the "tags" attribute should be ignored during lifecycle operations.
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# This block defines a resource of type "azurerm_private_dns_zone_virtual_network_link".
# This resource represents a link between a private DNS zone and a virtual network in Azure.
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each = var.virtual_networks_to_link

  name                  = "link_to_${lower(basename(each.key))}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = "/subscriptions/${each.value.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.key}"

  # This block specifies that changes to the "tags" attribute should be ignored during lifecycle operations.
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}