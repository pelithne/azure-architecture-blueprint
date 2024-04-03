// This block outputs the public IP address of the virtual machine.
// It retrieves the value from the 'public_ip_address' attribute of the 'virtual_machine' resource.
output "public_ip" {
  description = "Specifies the public IP address of the virtual machine"
  value       = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
}

// This block outputs the username of the virtual machine.
// It retrieves the value from the 'vm_user' variable.
output "username" {
  description = "Specifies the username of the virtual machine"
  value       = var.vm_user
}