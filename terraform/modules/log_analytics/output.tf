// The 'output' block defines an output variable
output "id" {
  // The 'value' attribute specifies the value of the output variable
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
  // The 'description' attribute provides a description of the output variable
  description = "Specifies the resource id of the log analytics workspace"
}

// The 'output' block defines an output variable
output "location" {
  // The 'value' attribute specifies the value of the output variable
  value = azurerm_log_analytics_workspace.log_analytics_workspace.location
  // The 'description' attribute provides a description of the output variable
  description = "Specifies the location of the log analytics workspace"
}

// The 'output' block defines an output variable
output "name" {
  // The 'value' attribute specifies the value of the output variable
  value = azurerm_log_analytics_workspace.log_analytics_workspace.name
  // The 'description' attribute provides a description of the output variable
  description = "Specifies the name of the log analytics workspace"
}

// The 'output' block defines an output variable
output "workspace_id" {
  // The 'value' attribute specifies the value of the output variable
  value = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  // The 'description' attribute provides a description of the output variable
  description = "Specifies the workspace id of the log analytics workspace"
}

// The 'output' block defines an output variable
output "primary_shared_key" {
  // The 'value' attribute specifies the value of the output variable
  value = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  // The 'description' attribute provides a description of the output variable
  description = "Specifies the workspace key of the log analytics workspace"
  // The 'sensitive' attribute specifies that the output contains sensitive data
  sensitive = true
}