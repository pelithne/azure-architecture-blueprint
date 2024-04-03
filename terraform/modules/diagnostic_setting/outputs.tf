// This block defines an output variable named "name". 
// This output variable will contain the name of the key vault.
output "name" {
  value = azurerm_key_vault.key_vault.name // The value of this output variable is the name of the key vault.
  description = "Specifies the name of the key vault." // Description of the output variable.
}

// This block defines an output variable named "id". 
// This output variable will contain the resource ID of the key vault.
output "id" {
  value = azurerm_key_vault.key_vault.id // The value of this output variable is the resource ID of the key vault.
  description = "Specifies the resource id of the key vault." // Description of the output variable.
}