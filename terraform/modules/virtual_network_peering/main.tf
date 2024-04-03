// This block specifies the required provider and version for this Terraform configuration. 
// It requires the Azure provider (azurerm) version 3.50.0 or newer and Terraform version 0.14.9 or newer.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.50.0"
    }
  }

  required_version = ">= 0.14.9"
}

// This data block fetches the details of an existing Azure Virtual Network named vnet_1 in the specified resource group.
data "azurerm_virtual_network" "vnet_1" {
  name                = var.vnet_1_name
  resource_group_name = var.vnet_1_rg
}

// This data block fetches the details of an existing Azure Virtual Network named vnet_2 in the specified resource group.
data "azurerm_virtual_network" "vnet_2" {
  name                = var.vnet_2_name
  resource_group_name = var.vnet_2_rg
}

// This resource block creates a peering connection from vnet_1 to vnet_2. 
// It allows traffic to be forwarded and allows access to the virtual network.
resource "azurerm_virtual_network_peering" "peering" {
  name                      = var.peering_name_1_to_2
  resource_group_name       = var.vnet_1_rg
  virtual_network_name      = var.vnet_1_name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

// This resource block creates a peering connection from vnet_2 back to vnet_1. 
// It allows traffic to be forwarded and allows access to the virtual network.
resource "azurerm_virtual_network_peering" "peering-back" {
  name                      = var.peering_name_2_to_1
  resource_group_name       = var.vnet_2_rg
  virtual_network_name      = var.vnet_2_name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}