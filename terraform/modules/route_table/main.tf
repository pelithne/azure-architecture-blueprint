// This block specifies the required providers and version for the Terraform configuration.
// In this case, the Azure Resource Manager (azurerm) provider is required.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }

  // This line specifies the minimum required version of Terraform for this configuration.
  required_version = ">= 0.14.9"
}

// This data block fetches the current Azure client configuration.
data "azurerm_client_config" "current" {
}

// This resource block creates an Azure route table.
resource "azurerm_route_table" "rt" {
  // These lines specify the name, location, and resource group for the route table.
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  // This block defines a route for the route table.
  route {
    name                   = "kubenetfw_fw_r"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }

  // This block specifies that changes to the tags and route should be ignored during lifecycle events.
  lifecycle {
    ignore_changes = [
      tags,
      route
    ]
  }
}

// This resource block creates an association between a subnet and a route table.
resource "azurerm_subnet_route_table_association" "subnet_association" {
  // This line iterates over the subnets to associate.
  for_each = var.subnets_to_associate

  // These lines specify the subnet id and route table id for the association.
  subnet_id      = "/subscriptions/${each.value.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value.virtual_network_name}/subnets/${each.key}"
  route_table_id = azurerm_route_table.rt.id
}