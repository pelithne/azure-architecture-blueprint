output name {
  description = "Specifies the name of the virtual network"
  // The value of this output is the name of the Azure virtual network resource
  value       = azurerm_virtual_network.vnet.name
}

output vnet_id {
  description = "Specifies the resource id of the virtual network"
  // The value of this output is the ID of the Azure virtual network resource
  value       = azurerm_virtual_network.vnet.id
}

output subnet_ids {
  description = "Contains a list of the the resource id of the subnets"
  // The value of this output is a map where the keys are the names of the subnets and the values are their respective IDs
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}