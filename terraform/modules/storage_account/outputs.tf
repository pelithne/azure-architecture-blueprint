# This block declares an output named "name".
# This output will display the name of the storage account after Terraform applies the configuration.
output "name" {
    description = "Specifies the name of the storage account"
    value       = azurerm_storage_account.storage_account.name
}

# This block declares an output named "id".
# This output will display the resource id of the storage account after Terraform applies the configuration.
output "id" {
    description = "Specifies the resource id of the storage account"
    value       = azurerm_storage_account.storage_account.id
}

# This block declares an output named "primary_access_key".
# This output will display the primary access key of the storage account after Terraform applies the configuration.
output "primary_access_key" {
    description = "Specifies the primary access key of the storage account"
    value       = azurerm_storage_account.storage_account.primary_access_key
}

# This block declares an output named "principal_id".
# This output will display the principal id of the system assigned managed identity of the storage account after Terraform applies the configuration.
output "principal_id" {
    description = "Specifies the principal id of the system assigned managed identity of the storage account"
    value       = azurerm_storage_account.storage_account.identity[0].principal_id
}

# This block declares an output named "primary_blob_endpoint".
# This output will display the primary blob endpoint of the storage account after Terraform applies the configuration.
output "primary_blob_endpoint" {
    description = "Specifies the primary blob endpoint of the storage account"
    value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}