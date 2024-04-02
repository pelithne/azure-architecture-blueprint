variable "resource_group_name" {
  description = "(Required) Specifies the resource id of the resource group."
  type        = string
}

variable "name" {
  description = "(Required) Specifies the name of the AKS cluster."
  type        = string
}

variable "k8s_service_name" {
  description = "(Required) Specifies the name of the Kubernetes service."
  type        = string
}

variable "azure_load_balancer_internal" {
  description = "(Optional) Specifies whether the service is internal or not."
  type        = bool
}

variable "azure_load_balancer_internal_subnet" {
  description = "(Optional) Specifies the subnet name for the internal load balancer."
  type        = string
}

variable "azure_pls_create" {
  description = "(Optional) Specifies whether the service is internal or not."
  type        = bool
}

variable "k8s_service_port" {
  description = "(Optional) Specifies the port of the Kubernetes service."
  type        = string
}

variable "k8s_service_target_port" {
  description = "(Optional) Specifies the target port of the Kubernetes service."
  type        = string
}

variable "k8s_service_type" {
  description = "(Optional) Specifies the type of the Kubernetes service."
  type        = string
}
