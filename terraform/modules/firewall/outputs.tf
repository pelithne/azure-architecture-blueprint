# This block defines an output value that can be used by other configurations or modules.
# The output value is named "private_ip_address".
output "private_ip_address" {
  # This line provides a description of the output value.
  description = "Specifies the private IP address of the firewall."

  # This line specifies the value of the output.
  # It retrieves the private IP address of the first IP configuration of the Azure Firewall resource.
  value = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}