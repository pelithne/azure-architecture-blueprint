// This block defines an output for this Terraform module.
output "id" {
  // The description attribute provides a human-readable description of the output. This is used to describe the purpose of the output.
  description = "Specifies the resource id of the node pool"
  // The value attribute specifies the value of the output. In this case, it is the id of the node pool created by the azurerm_kubernetes_cluster_node_pool resource.
  value       = azurerm_kubernetes_cluster_node_pool.node_pool.id
}