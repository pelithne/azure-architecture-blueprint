// This block declares a variable named "resource_group_name". 
// This variable is required and should specify the name of the resource group for the bastion host.
variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the bastion host"
  type        = string
}

// This block declares a variable named "name". 
// This variable is required and should specify the name of the bastion host.
variable "name" {
  description = "(Required) Specifies the name of the bastion host"
  type        = string
}

// This block declares a variable named "location". 
// This variable is required and should specify the location where the bastion host will be created.
variable "location" {
  description = "(Required) Specifies the location of the bastion host"
  type        = string
}

// This block declares a variable named "tags". 
// This variable is optional and should specify any tags to be associated with the bastion host.
variable "tags" {
  description = "(Optional) Specifies the tags of the bastion host"
  default     = {} // If no tags are provided, it defaults to an empty map.
}

// This block declares a variable named "subnet_id". 
// This variable is required and should specify the ID of the subnet where the bastion host will be created.
variable "subnet_id" {
  description = "(Required) Specifies subnet id of the bastion host"
  type        = string
}

// This block declares a variable named "log_analytics_workspace_id". 
// This variable should specify the ID of the Log Analytics workspace where the diagnostic data will be sent.
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}