// This block defines an output variable named "name". 
// This output variable will contain the name of the container registry.
output "name" {
  description = "Specifies the name of the container registry."
  value       = azurerm_container_registry.acr.name // The value of this output variable is the name of the container registry.
}

// This block defines an output variable named "id". 
// This output variable will contain the resource ID of the container registry.
output "id" {
  description = "Specifies the resource id of the container registry."
  value       = azurerm_container_registry.acr.id // The value of this output variable is the resource ID of the container registry.
}

// This block defines an output variable named "login_server". 
// This output variable will contain the login server of the container registry.
output "login_server" {
  description = "Specifies the login server of the container registry."
  value = azurerm_container_registry.acr.login_server // The value of this output variable is the login server of the container registry.
}

// This block defines an output variable named "login_server_url". 
// This output variable will contain the login server URL of the container registry.
output "login_server_url" {
  description = "Specifies the login server url of the container registry."
  value = "https://${azurerm_container_registry.acr.login_server}" // The value of this output variable is the login server URL of the container registry.
}

// This block defines an output variable named "admin_username". 
// This output variable will contain the admin username of the container registry.
output "admin_username" {
  description = "Specifies the admin username of the container registry."
  value = azurerm_container_registry.acr.admin_username // The value of this output variable is the admin username of the container registry.
}