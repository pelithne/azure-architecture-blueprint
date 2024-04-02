data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.name
  resource_group_name = var.resource_group_name
}

#provider "azurerm" {
#  features {}
#}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_service" "aks_cluster" {
  metadata {
    name = var.k8s_service_name
    annotations = {
      "service.beta.kubernetes.io/azure-load-balancer-internal" = var.azure_load_balancer_internal
      "service.beta.kubernetes.io/azure-load-balancer-internal-subnet" = var.azure_load_balancer_internal_subnet
      "service.beta.kubernetes.io/azure-pls-create" = var.azure_pls_create
    }
  }
  spec {
    port {
      port        = var.k8s_service_port
      target_port = var.k8s_service_target_port
    }
    type = var.k8s_service_type
  }
}
