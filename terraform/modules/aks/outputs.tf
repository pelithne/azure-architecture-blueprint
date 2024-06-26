# Output block for the name of the AKS cluster
output "name" {
  value       = azurerm_kubernetes_cluster.aks_cluster.name
  description = "Specifies the name of the AKS cluster."
}

# Output block for the resource id of the AKS cluster
output "id" {
  value       = azurerm_kubernetes_cluster.aks_cluster.id
  description = "Specifies the resource id of the AKS cluster."
}

# Output block for the principal id of the managed identity of the AKS cluster
output "aks_identity_principal_id" {
  value       = azurerm_user_assigned_identity.aks_identity.principal_id
  description = "Specifies the principal id of the managed identity of the AKS cluster."
}

# Output block for the object id of the kubelet identity of the AKS cluster
output "kubelet_identity_object_id" {
  value       = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity.0.object_id
  description = "Specifies the object id of the kubelet identity of the AKS cluster."
}

# Output block for the Kubernetes config to be used by kubectl and other compatible tools
output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  description = "Contains the Kubernetes config to be used by kubectl and other compatible tools."
}

# Output block for the FQDN for the Kubernetes Cluster when private link has been enabled
output "private_fqdn" {
  value       = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
}