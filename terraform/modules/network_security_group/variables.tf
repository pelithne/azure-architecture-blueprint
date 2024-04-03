// The 'variable' block defines a variable named 'name'
variable "name" {
  // The 'description' attribute provides a description of the variable
  description = "(Required) Specifies the name of the network security group"
  // The 'type' attribute specifies the type of the variable
  type        = string
}

// The 'variable' block defines a variable named 'resource_group_name'
variable "resource_group_name" {
  // The 'description' attribute provides a description of the variable
  description = "(Required) Specifies the resource group name of the network security group"
  // The 'type' attribute specifies the type of the variable
  type        = string
}

// The 'variable' block defines a variable named 'location'
variable "location" {
  // The 'description' attribute provides a description of the variable
  description = "(Required) Specifies the location of the network security group"
  // The 'type' attribute specifies the type of the variable
  type        = string
}

// The 'variable' block defines a variable named 'security_rules'
variable "security_rules" {
  // The 'description' attribute provides a description of the variable
  description = "(Optional) Specifies the security rules of the network security group"
  // The 'type' attribute specifies the type of the variable
  type        = list(object)
  // The 'default' attribute specifies the default value of the variable
  default     = []
}

// The 'variable' block defines a variable named 'tags'
variable "tags" {
  // The 'description' attribute provides a description of the variable
  description = "(Optional) Specifies the tags of the network security group"
  // The 'default' attribute specifies the default value of the variable
  default     = {}
}

// The 'variable' block defines a variable named 'log_analytics_workspace_id'
variable "log_analytics_workspace_id" {
  // The 'description' attribute provides a description of the variable
  description = "Specifies the log analytics workspace resource id"
  // The 'type' attribute specifies the type of the variable
  type        = string
}