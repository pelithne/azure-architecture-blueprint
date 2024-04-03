// The 'variable' block defines an input variable
variable "resource_group_name" {
    // The 'description' attribute provides a description of the variable
    description = "(Required) Specifies the resource group name"
    // The 'type' attribute specifies the type of the variable
    type = string
}

// The 'variable' block defines an input variable
variable "location" {
    // The 'description' attribute provides a description of the variable
    description = "(Required) Specifies the location of the log analytics workspace"
    // The 'type' attribute specifies the type of the variable
    type = string
}

// The 'variable' block defines an input variable
variable "name" {
    // The 'description' attribute provides a description of the variable
    description = "(Required) Specifies the name of the log analytics workspace"
    // The 'type' attribute specifies the type of the variable
    type = string
}

// The 'variable' block defines an input variable
variable "sku" {
    // The 'description' attribute provides a description of the variable
    description = "(Optional) Specifies the sku of the log analytics workspace"
    // The 'type' attribute specifies the type of the variable
    type = string
    // The 'default' attribute specifies the default value of the variable
    default = "PerGB2018"
    
    // The 'validation' block is used to define validation rules for the variable
    validation {
        // The 'condition' attribute specifies the condition that must be true for the variable to be valid
        condition = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.sku)
        // The 'error_message' attribute specifies the error message to display if the condition is false
        error_message = "The log analytics sku is incorrect."
    }
}

// The 'variable' block defines an input variable
variable "solution_plan_map" {
    // The 'description' attribute provides a description of the variable
    description = "(Optional) Specifies the map structure containing the list of solutions to be enabled."
    // The 'type' attribute specifies the type of the variable
    type        = map(any)
    // The 'default' attribute specifies the default value of the variable
    default     = {}
}

// The 'variable' block defines an input variable
variable "tags" {
    // The 'description' attribute provides a description of the variable
    description = "(Optional) Specifies the tags of the log analytics workspace"
    // The 'type' attribute specifies the type of the variable
    type        = map(any)
    // The 'default' attribute specifies the default value of the variable
    default     = {}
}

// The 'variable' block defines an input variable
variable "retention_in_days" {
    // The 'description' attribute provides a description of the variable
    description = " (Optional) Specifies the workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
    // The 'type' attribute specifies the type of the variable
    type        = number
    // The 'default' attribute specifies the default value of the variable
    default     = 30
}