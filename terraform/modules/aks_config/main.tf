// Fetches the details of an existing Azure Kubernetes Service (AKS) cluster.
data "azurerm_kubernetes_cluster" "aks_cluster" {
  // The name of the AKS cluster.
  name                = var.name
  // The name of the resource group that the AKS cluster belongs to.
  resource_group_name = var.resource_group_name
}

// The provider block for the Kubernetes provider.
provider "kubernetes" {
  // The hostname (or IP address) of the Kubernetes master.
  host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  // The client certificate for authenticating to the Kubernetes master.
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  // The client key for authenticating to the Kubernetes master.
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  // The certificate authority data for the Kubernetes master.
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}

// Defines a Kubernetes service.
resource "kubernetes_service" "aks_cluster" {
  // Metadata about the service.
  metadata {
    // The name of the service.
    name = var.k8s_service_name
    // Annotations for the service.
    annotations = {
      // Specifies whether the Azure load balancer should be internal.
      "service.beta.kubernetes.io/azure-load-balancer-internal" = var.azure_load_balancer_internal
      // Specifies the subnet for the internal Azure load balancer.
      "service.beta.kubernetes.io/azure-load-balancer-internal-subnet" = var.azure_load_balancer_internal_subnet
      // Specifies whether the Azure Private Link Service should be created.
      "service.beta.kubernetes.io/azure-pls-create" = var.azure_pls_create
    }
  }
  // The specification of the service.
  spec {
    // The port configuration for the service.
    port {
      // The port that the service listens on.
      port        = var.k8s_service_port
      // The port of the target pods that the service forwards traffic to.
      target_port = var.k8s_service_target_port
    }
    // The type of the service.
    type = var.k8s_service_type
  }
}