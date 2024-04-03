// The 'output' block defines an output value
output "id" {
  // The 'description' attribute provides a description of the output
  description = "Specifies the resource id of the network security group"
  // The 'value' attribute specifies the value of the output
  value       = azurerm_network_security_group.nsg.id
}