// This variable is used to specify the name of the Azure Resource Group where resources will be deployed
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

// This variable is used to specify the Azure region where the resources will be deployed
variable "location" {
  description = "Location in which to deploy the network"
  type        = string
}

// This variable is used to specify the name of the Azure Virtual Network to be created
variable "vnet_name" {
  description = "VNET name"
  type        = string
}

// This variable is used to specify the IP address range for the Azure Virtual Network
variable "address_space" {
  description = "VNET address space"
  type        = list(string)
}

// This variable is used to specify the configuration of the subnets within the Azure Virtual Network
variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    private_endpoint_network_policies_enabled      = bool
    private_link_service_network_policies_enabled  = bool
  }))
}

// This variable is used to specify the tags to be assigned to the Azure Storage Account. It is optional and defaults to an empty map
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}

// This variable is used to specify the ID of the Azure Log Analytics Workspace where logs will be sent
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}