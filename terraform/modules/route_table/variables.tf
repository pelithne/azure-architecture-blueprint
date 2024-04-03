// This block declares a variable named "resource_group_name".
// This variable is used to specify the resource group where the RouteTable will be deployed.
// The type of this variable is string.
variable "resource_group_name" {
  description = "Resource group where RouteTable will be deployed"
  type        = string
}

// This block declares a variable named "location".
// This variable is used to specify the location where the RouteTable will be deployed.
// The type of this variable is string.
variable "location" {
  description = "Location where RouteTable will be deployed"
  type        = string
}

// This block declares a variable named "route_table_name".
// This variable is used to specify the name of the RouteTable.
// The type of this variable is string.
variable "route_table_name" {
  description = "RouteTable name"
  type        = string
}

// This block declares a variable named "route_name".
// This variable is used to specify the name of the AKS route.
// The type of this variable is string.
variable "route_name" {
  description = "AKS route name"
  type        = string
}

// This block declares a variable named "firewall_private_ip".
// This variable is used to specify the private IP of the firewall.
// The type of this variable is string.
variable "firewall_private_ip" {
  description = "Firewall private IP"
  type        = string
}

// This block declares a variable named "subnets_to_associate".
// This variable is used to specify the subscription id, resource group name, and name of the subnets to associate.
// The type of this variable is map, and its default value is an empty map.
variable "subnets_to_associate" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the subnets to associate"
  type        = map(any)
  default     = {}
}

// This block declares a variable named "tags".
// This variable is used to specify the tags of the storage account.
// The type of this variable is map, and its default value is an empty map.
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}