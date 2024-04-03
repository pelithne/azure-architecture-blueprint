// This variable is used to specify the name of the resource group in Azure.
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

// This variable is used to specify the location where the network will be deployed in Azure.
variable "location" {
  description = "Location in which to deploy the network"
  type        = string
}

// This variable is used to specify the name of the virtual network in Azure.
variable "vnet_name" {
  description = "VNET name"
  type        = string
}

// This variable is used to specify the address space of the virtual network in Azure.
variable "address_space" {
  description = "VNET address space"
  type        = list(string)
}

// This variable is used to specify the configuration of the subnets in the virtual network.
variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    private_endpoint_network_policies_enabled      = bool
    private_link_service_network_policies_enabled  = bool
  }))
}

// This variable is used to specify the tags of the storage account in Azure. It is optional and defaults to an empty map.
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}

// This variable is used to specify the ID of the log analytics workspace in Azure.
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}