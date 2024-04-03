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

// This block defines a variable named "target_resource_id". 
// This variable specifies the ID of an existing Resource on which to configure Diagnostic Settings. 
// Changing this variable will force a new resource to be created.
variable "target_resource_id" {
  description = "(Required) The ID of an existing Resource on which to configure Diagnostic Settings. Changing this forces a new resource to be created."
  type        = string
}

// This block defines a variable named "log_analytics_workspace_id". 
// This variable specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent.
variable "log_analytics_workspace_id" {
  description = "(Optional) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
  type        = string
}

// This block defines a variable named "log_analytics_destination_type". 
// This variable specifies the destination type for the Log Analytics data. 
// When set to 'Dedicated', logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table.
variable "log_analytics_destination_type" {
  description = "(Optional) When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  type        = string
  default     = null
}

// This block defines a variable named "storage_account_id". 
// This variable specifies the ID of the Storage Account where logs should be sent. 
// Changing this variable will force a new resource to be created.
variable "storage_account_id" {
  description = "(Optional) The ID of the Storage Account where logs should be sent. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

// This block defines a variable named "eventhub_name". 
// This variable specifies the name of the Event Hub where Diagnostics Data should be sent. 
// Changing this variable will force a new resource to be created.
variable "eventhub_name" {
  description = "(Optional) Specifies the name of the Event Hub where Diagnostics Data should be sent. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

// This block defines a variable named "eventhub_authorization_rule_id". 
// This variable specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. 
// Changing this variable will force a new resource to be created.
variable "eventhub_authorization_rule_id" {
  description = "(Optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

// This block defines a variable named "logs". 
// This variable specifies a list of log categories to enable.
variable "logs" {
  description = "(Optional) Specifies a list of log categories to enable."
  type        = list(string)
  default     = []
}

// This block defines a variable named "metrics". 
// This variable specifies a list of metrics to enable.
variable "metrics" {
  description = "(Optional) Specifies a list of metrics to enable."
  type        = list(string)
  default     = []
}

// This block defines a variable named "tags". 
// This variable specifies a mapping of tags to assign to the resource.
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}