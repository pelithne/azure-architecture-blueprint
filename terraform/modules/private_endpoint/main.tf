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

# This block defines a resource of type "azurerm_private_endpoint".
# This resource represents a private endpoint in Azure.
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  # This block defines a private service connection for the private endpoint.
  private_service_connection {
    name                           = "${var.name}Connection"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = try([var.subresource_name], null)
    request_message                = try(var.request_message, null)
  }

  # This block defines a private DNS zone group for the private endpoint.
  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_group_ids
  }

  # This block specifies that changes to the "tags" attribute should be ignored during lifecycle operations.
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}