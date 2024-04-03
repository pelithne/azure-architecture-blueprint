// This block defines an output value named "id".
// This output value represents the resource id of the private endpoint.
output "id" {
  description = "Specifies the resource id of the private endpoint."
  value       = azurerm_private_endpoint.private_endpoint.id
}

// This block defines an output value named "private_dns_zone_group".
// This output value represents the private DNS zone group of the private endpoint.
output "private_dns_zone_group" {
  description = "Specifies the private dns zone group of the private endpoint."
  value = azurerm_private_endpoint.private_endpoint.private_dns_zone_group
}

// This block defines an output value named "private_dns_zone_configs".
// This output value represents the private DNS zone(s) configuration of the private endpoint.
output "private_dns_zone_configs" {
  description = "Specifies the private dns zone(s) configuration"
  value = azurerm_private_endpoint.private_endpoint.private_dns_zone_configs
}