// This output returns the name of the virtual network that was created.
output name {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

// This output returns the resource ID of the virtual network that was created.
output vnet_id {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

// This output returns a map where the keys are the names of the subnets that were created and the values are their respective resource IDs.
output subnet_ids {
 description = "Contains a list of the the resource id of the subnets"
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}