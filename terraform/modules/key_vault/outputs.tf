// Output block for the 'name' of the Azure Key Vault
output "name" {
  // The 'value' attribute is set to the 'name' property of the Azure Key Vault resource
  value = azurerm_key_vault.key_vault.name
  // The 'description' attribute provides a brief explanation of the output
  description = "Specifies the name of the key vault."
}

// Output block for the 'id' of the Azure Key Vault
output "id" {
  // The 'value' attribute is set to the 'id' property of the Azure Key Vault resource
  value = azurerm_key_vault.key_vault.id
  // The 'description' attribute provides a brief explanation of the output
  description = "Specifies the resource id of the key vault."
}