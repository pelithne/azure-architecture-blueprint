# This block defines an output value that can be used by other configurations or modules.
# Output values are like return values for a Terraform module.
output "id" {
  # This line provides a description of the output. It is used to describe the purpose or usage of the output.
  description = "Specifies the resource id of the private dns zone"

  # This line specifies the value of the output. In this case, it is the id of the "azurerm_private_dns_zone" resource named "private_dns_zone".
  value       = azurerm_private_dns_zone.private_dns_zone.id
}