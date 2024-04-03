// This block defines a variable named "name". 
// This variable specifies the name of the Container Registry. 
// Changing this variable will force a new resource to be created.
variable "name" {
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
  type        = string
}

// This block defines a variable named "resource_group_name". 
// This variable specifies the name of the resource group in which to create the Container Registry. 
// Changing this variable will force a new resource to be created.
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
}

// This block defines a variable named "location". 
// This variable specifies the supported Azure location where the resource exists. 
// Changing this variable will force a new resource to be created.
variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

// This block defines a variable named "admin_enabled". 
// This variable specifies whether the admin user is enabled. 
// The default value is false.
variable "admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  type        = string
  default     = false
}

// This block defines a variable named "sku". 
// This variable specifies the SKU name of the container registry. 
// Possible values are Basic, Standard and Premium. The default value is Basic.
variable "sku" {
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  type        = string
}

// This block defines a variable named "tags". 
// This variable specifies a mapping of tags to assign to the resource. 
// The default value is an empty map.
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

// This block defines a variable named "georeplication_locations". 
// This variable specifies a list of Azure locations where the container registry should be geo-replicated.
variable "georeplication_locations" {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
}

// This block defines a variable named "log_analytics_workspace_id". 
// This variable specifies the log analytics workspace id.
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}