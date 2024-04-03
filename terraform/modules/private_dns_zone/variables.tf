// This block declares a variable named "name".
// This variable is used to specify the name of the private DNS zone.
// The type of this variable is string.
variable "name" {
  description = "(Required) Specifies the name of the private dns zone"
  type        = string
}

// This block declares a variable named "resource_group_name".
// This variable is used to specify the resource group name of the private DNS zone.
// The type of this variable is string.
variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the private dns zone"
  type        = string
}

// This block declares a variable named "tags".
// This variable is used to specify the tags of the private DNS zone.
// The type of this variable is map, and its default value is an empty map.
variable "tags" {
  description = "(Optional) Specifies the tags of the private dns zone"
  default     = {}
}

// This block declares a variable named "virtual_networks_to_link".
// This variable is used to specify the subscription id, resource group name, and name of the virtual networks to which create a virtual network link.
// The type of this variable is map, and its default value is an empty map.
variable "virtual_networks_to_link" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the virtual networks to which create a virtual network link"
  type        = map(any)
  default     = {}
}