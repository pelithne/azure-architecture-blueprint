// This block defines an output variable named "object". 
// This output variable will contain the entire bastion host resource.
output "object" {
  depends_on = [azurerm_bastion_host.bastion_host]    // This output depends on the creation of the bastion host resource.
  value = azurerm_bastion_host.bastion_host           // The value of this output variable is the entire bastion host resource.
  description = "Contains the bastion host resource"  // A description of this output variable.
}

// This block defines an output variable named "name". 
// This output variable will contain the name of the bastion host.
output "name" {
  depends_on = [azurerm_bastion_host.bastion_host]        // This output depends on the creation of the bastion host resource.
  value = azurerm_bastion_host.bastion_host.*.name        // The value of this output variable is the name of the bastion host.
  description = "Specifies the name of the bastion host"  // A description of this output variable.
}

// This block defines an output variable named "id". 
// This output variable will contain the resource ID of the bastion host.
output "id" {
  depends_on = [azurerm_bastion_host.bastion_host]              // This output depends on the creation of the bastion host resource.
  value = azurerm_bastion_host.bastion_host.*.id                // The value of this output variable is the resource ID of the bastion host.
  description = "Specifies the resource id of the bastion host" // A description of this output variable.
}