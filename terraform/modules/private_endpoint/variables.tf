// This block declares a variable named "name".
// This variable is used to specify the name of the private endpoint.
// The type of this variable is string.
variable "name" {
  description = "(Required) Specifies the name of the private endpoint. Changing this forces a new resource to be created."
  type        = string
}

// This block declares a variable named "resource_group_name".
// This variable is used to specify the name of the resource group.
// The type of this variable is string.
variable "resource_group_name" {
  description = "(Required) The name of the resource group. Changing this forces a new resource to be created."
  type        = string
}

// This block declares a variable named "private_connection_resource_id".
// This variable is used to specify the resource id of the private link service.
// The type of this variable is string.
variable "private_connection_resource_id" {
  description = "(Required) Specifies the resource id of the private link service"
  type        = string 
}

// This block declares a variable named "location".
// This variable is used to specify the supported Azure location where the resource exists.
// The type of this variable is string.
variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

// This block declares a variable named "subnet_id".
// This variable is used to specify the resource id of the subnet.
// The type of this variable is string.
variable "subnet_id" {
  description = "(Required) Specifies the resource id of the subnet"
  type        = string
}

// This block declares a variable named "is_manual_connection".
// This variable is used to specify whether the private endpoint connection requires manual approval from the remote resource owner.
// The type of this variable is string, and its default value is false.
variable "is_manual_connection" {
  description = "(Optional) Specifies whether the private endpoint connection requires manual approval from the remote resource owner."
  type        = string
  default     = false  
}

// This block declares a variable named "subresource_name".
// This variable is used to specify a subresource name which the Private Endpoint is able to connect to.
// The type of this variable is string, and its default value is null.
variable "subresource_name" {
  description = "(Optional) Specifies a subresource name which the Private Endpoint is able to connect to."
  type        = string
  default     = null
}

// This block declares a variable named "request_message".
// This variable is used to specify a message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource.
// The type of this variable is string, and its default value is null.
variable "request_message" {
  description = "(Optional) Specifies a message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource."
  type        = string
  default     = null 
}

// This block declares a variable named "private_dns_zone_group_name".
// This variable is used to specify the Name of the Private DNS Zone Group.
// The type of this variable is string.
variable "private_dns_zone_group_name" {
  description = "(Required) Specifies the Name of the Private DNS Zone Group. Changing this forces a new private_dns_zone_group resource to be created."
  type        = string
}

// This block declares a variable named "private_dns_zone_group_ids".
// This variable is used to specify the list of Private DNS Zones to include within the private_dns_zone_group.
// The type of this variable is list of strings.
variable "private_dns_zone_group_ids" {
  description = "(Required) Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
  type        = list(string)
}

// This block declares a variable named "tags".
// This variable is used to specify the tags of the network security group.
// The type of this variable is map, and its default value is an empty map.
variable "tags" {
  description = "(Optional) Specifies the tags of the network security group"
  default     = {}
}

// This block declares a variable named "private_dns".
// The type of this variable is map, and its default value is an empty map.
variable "private_dns" {
  default = {}
}