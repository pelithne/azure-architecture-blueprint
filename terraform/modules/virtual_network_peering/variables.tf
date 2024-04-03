// This variable holds the name of the first virtual network.
variable "vnet_1_name" {
  description = "Specifies the name of the first virtual network"
  type        = string
}

// This variable holds the resource id of the first virtual network.
variable "vnet_1_id" {
  description = "Specifies the resource id of the first virtual network"
  type        = string
}

// This variable holds the resource group name of the first virtual network.
variable "vnet_1_rg" {
  description = "Specifies the resource group name of the first virtual network"
  type        = string
}

// This variable holds the name of the second virtual network.
variable "vnet_2_name" {
  description = "Specifies the name of the second virtual network"
  type        = string
}


// This variable holds the resource id of the second virtual network.
variable "vnet_2_id" {
  description = "Specifies the resource id of the second virtual network"
  type        = string
}

// This variable holds the resource group name of the second virtual network.
variable "vnet_2_rg" {
  description = "Specifies the resource group name of the second virtual network"
  type        = string
}


//  This variable holds the name of the peering from the first to the second virtual network. It's optional and defaults to "peering1to2" if not provided.
variable "peering_name_1_to_2" {
  description = "(Optional) Specifies the name of the first to second virtual network peering"
  type        = string
  default     = "peering1to2"
}
// This variable holds the name of the peering from the second to the first virtual network. It's optional and defaults to "peering2to1" if not provided.
variable "peering_name_2_to_1" {
  description = "(Optional) Specifies the name of the second to first virtual network peering"
  type        = string
  default     = "peering2to1"
}