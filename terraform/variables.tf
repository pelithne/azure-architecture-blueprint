variable "log_analytics_workspace_name" {
  description = "Specifies the name of the log analytics workspace"
  default     = "AksWorkspace"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 30
}

variable "solution_plan_map" {
  description = "Specifies solutions to deploy to log analytics workspace"
  default     = {
    ContainerInsights= {
      product   = "OMSGallery/ContainerInsights"
      publisher = "Microsoft"
    }
  }
  type = map(any)
}

variable "hub_location" {
  description = "Specifies the location for the resource group and all the resources"
  default     = "eastus2"
  type        = string
}

variable "spoke_location" {
  description = "Specifies the location for the resource group and all the resources"
  default     = "westus2"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Specifies the hub resource group name"
  default     = "hub-rg"
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Specifies the spoke resource group name"
  default     = "spoke-rg"
  type        = string
}

variable "hub_vnet_name" {
  description = "Specifies the name of the hub virtual virtual network"
  default     = "vnet200-lab1-mgmt"
  type        = string
}

variable "hub_vnet_address_space" {
  description = "Specifies the address space of the hub virtual virtual network"
  default     = ["10.0.0.0/22"]
  type        = list(string)
}




variable "hub_firewall_subnet_address_prefix" {
  description = "Specifies the address prefix of the firewall subnet"
  default     = ["10.0.0.0/26"]
  type        = list(string)
}


variable "vm_subnet_name" {
  description = "Specifies the name of the jumpbox subnet"
  default     = "jumpbox-subnet"
  type        = string
}

variable "vm_subnet_address_prefix" {
  description = "Specifies the address prefix of the jumpbox subnet"
  default     = ["10.0.0.64/26"]
  type        = list(string)
}

variable "spoke_vnet_name" {
  description = "Specifies the name of the AKS subnet"
  default     = "vnet201-lab1-aks"
  type        = string
}

variable "spoke_vnet_address_space" {
  description = "Specifies the address prefix of the AKS subnet"
  default     =  ["10.1.0.0/20"]
  type        = list(string)
}

variable "aks_cluster_name" {
  description = "(Required) Specifies the name of the AKS cluster."
  default     = "aks-cluster"
  type        = string
}

variable "aks_outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  type        = string
  default     = "userDefinedRouting"

  validation {
    condition = contains(["loadBalancer", "userDefinedRouting"], var.aks_outbound_type)
    error_message = "The outbound type is invalid."
  }
}

variable "aks_sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = "Paid"
  type        = string

  validation {
    condition = contains( ["Free", "Paid"], var.aks_sku_tier)
    error_message = "The sku tier is invalid."
  }
}

variable "pe_subnet_name" {
  description = "Specifies the name of the private endpoint subnet"
  default     = "subnet-priv-endpoint"
  type        = string
}

variable "pe_subnet_address_prefix" {
  description = "Specifies the address prefix of the private endpoint subnet"
  default     = ["10.1.1.16/28"]
  type        = list(string)
}

variable "lb_subnet_name" {
  description = "Specifies the name of the lb subnet"
  default     = "subnet-lb"
  type        = string
}

variable "lb_subnet_address_prefix" {
  description = "Specifies the address prefix of the lb subnet"
  default     = ["10.1.1.0/28"]
  type        = list(string)
}

variable "pod_subnet_name" {
  description = "Specifies the name of the pod subnet."
  default     =  "subnet-aks-pods"
  type        = string
}

variable "pod_subnet_address_prefix" {
  description = "Specifies the address prefix of the pod subnet"
  type        = list(string)
  default     = ["10.1.3.0/24"]
}

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     =  "system"
  type        = string
}

variable "default_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     =  "subnet-aks-system-nodepool"
  type        = string
}

variable "default_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the default node pool"
  default     =  ["10.1.0.0/24"]
  type        = list(string)
}

variable "role_based_access_control_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  default     = true
  type        = bool
}

variable "automatic_channel_upgrade" {
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, and stable."
  default     = "stable"
  type        = string

  validation {
    condition = contains( ["patch", "rapid", "stable"], var.automatic_channel_upgrade)
    error_message = "The upgrade mode is invalid."
  }
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Microsoft Entra ID Groups which should have Admin Role on the Cluster."
  default     = ["9bfd16dc-a556-4a11-9f8b-e6ca70443ce8"]
  type        = list(string)
}

variable "azure_rbac_enabled" {
  description = "(Optional) Is Role Based Access Control based on Microsoft Entra ID enabled?"
  default     = true
  type        = bool
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  default     = "1.27.9"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "standard_d2as_v5"
  type        = string
}

variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.2.0.10"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}


variable "default_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to true."
  type          = bool
  default       = true
}

variable "default_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type          = bool
  default       = false
} 

variable "default_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type          = bool
  default       = false
} 

variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type          = number
  default       = 50
}

variable "system_node_pool_node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

variable "system_node_pool_node_taints" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = list(string)
  default       = ["CriticalAddonsOnly=true:NoSchedule"]
} 

variable "default_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type          = string
  default       = "Managed"
} 

variable "default_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 10
}

variable "default_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 1
}

variable "default_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 1
}

variable "additional_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     =  "subnet-aks-nodes"
  type        = string
}

variable "additional_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the additional node pool"
  type        = list(string)
  default     = ["10.1.4.0/24"]
}

variable "additional_node_pool_name" {
  description = "(Required) Specifies the name of the node pool."
  type        = string
  default     = "user"
}

variable "additional_node_pool_vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "standard_d2as_v5"
}

variable "additional_node_pool_availability_zones" {
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
  type        = list(string)
  default = ["1", "2", "3"]
}

variable "additional_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type          = bool
  default       = true
}

variable "additional_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type          = bool
  default       = false
} 

variable "additional_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type          = bool
  default       = false
} 

variable "additional_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type          = number
  default       = 50
}

variable "additional_node_pool_mode" {
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
  type          = string
  default       = "User"
} 

variable "additional_node_pool_node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

variable "additional_node_pool_node_taints" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = list(string)
  default       = []
} 

variable "additional_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type          = string
  default       = "Managed"
} 

variable "additional_node_pool_os_type" {
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
  type          = string
  default       = "Linux"
} 

variable "additional_node_pool_priority" {
  description = "(Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  type          = string
  default       = "Regular"
} 

variable "additional_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 10
}

variable "additional_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 1
}

variable "additional_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 1
}

variable "domain_name_label" {
  description = "Specifies the domain name for the jumbox virtual machine"
  default     = "jumpbox"
  type        = string
}

variable "vm_name" {
  description = "Specifies the name of the jumpbox virtual machine"
  default     = "Jumpbox-VM"
  type        = string
}

variable "firewall_name" {
  description = "Specifies the name of the Azure Firewall"
  default     = "Azure-Firewall"
  type        = string
}

variable "firewall_sku_name" {
  description = "(Required) SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
  default     = "AZFW_VNet"
  type        = string

  validation {
    condition = contains(["AZFW_Hub", "AZFW_VNet" ], var.firewall_sku_name)
    error_message = "The value of the sku name property of the firewall is invalid."
  }
}

variable "firewall_sku_tier" {
  description = "(Required) SKU tier of the Firewall. Possible values are Premium, Standard, and Basic."
  default     = "Standard"
  type        = string

  validation {
    condition = contains(["Premium", "Standard", "Basic" ], var.firewall_sku_tier)
    error_message = "The value of the sku tier property of the firewall is invalid."
  }
}

variable "firewall_threat_intel_mode" {
  description = "(Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny. Defaults to Alert."
  default     = "Alert"
  type        = string

  validation {
    condition = contains(["Off", "Alert", "Deny"], var.firewall_threat_intel_mode)
    error_message = "The threat intel mode is invalid."
  }
}

variable "firewall_zones" {
  description = "Specifies the availability zones of the Azure Firewall"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "vm_public_ip" {
  description = "(Optional) Specifies whether create a public IP for the virtual machine"
  type = bool
  default = false
}

variable "vm_size" {
  description = "Specifies the size of the jumpbox virtual machine"
  default     = "standard_d2as_v5"
  type        = string
}

variable "vm_os_disk_storage_account_type" {
  description = "Specifies the storage account type of the os disk of the jumpbox virtual machine"
  default     = "Standard_LRS"
  type        = string

  validation {
    condition = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS",  "Standard_LRS"], var.vm_os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid."
  }
}

variable "vm_os_disk_image" {
  type        = map(string)
  description = "Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2" 
    version   = "latest"
  }
}

variable "acr_name" {
  description = "Specifies the name of the container registry"
  type        = string
  default     = "acrpelithneprivate222"
}

variable "acr_sku" {
  description = "Specifies the name of the container registry"
  type        = string
  default     = "Premium"

  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "The container registry sku is invalid."
  }
}

variable "acr_admin_enabled" {
  description = "Specifies whether admin is enabled for the container registry"
  type        = bool
  default     = false
}

variable "acr_georeplication_locations" {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default     = {
    createdWith = "Terraform"
  }
}

variable "bastion_host_name" {
  description = "(Optional) Specifies the name of the bastion host"
  default     = "BastionHost"
  type        = string
}

variable "hub_bastion_subnet_address_prefix" {
  description = "Specifies the address prefix of the firewall subnet"
  default     = ["10.0.0.128/26"]
  type        = list(string)
}

variable "key_vault_name" {
  description = "Specifies the name of the key vault."
  type        = string
  default     = "kvalipelithne22222"
}

variable "key_vault_sku_name" {
  description = "(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"

  validation {
    condition = contains(["standard", "premium" ], var.key_vault_sku_name)
    error_message = "The sku name of the key vault is invalid."
  }
}

variable"key_vault_enabled_for_deployment" {
  description = "(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false."
  type        = bool
  default     = true
}

variable"key_vault_enabled_for_disk_encryption" {
  description = " (Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false."
  type        = bool
  default     = false
}

variable"key_vault_enabled_for_template_deployment" {
  description = "(Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false."
  type        = bool
  default     = true
}

variable"key_vault_enable_rbac_authorization" {
  description = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false."
  type        = bool
  default     = true
}

variable"key_vault_purge_protection_enabled" {
  description = "(Optional) Is Purge Protection enabled for this Key Vault? Defaults to false."
  type        = bool
  default     = true
}

variable "key_vault_soft_delete_retention_days" {
  description = "(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days."
  type        = number
  default     = 10
}

variable "key_vault_bypass" { 
  description = "(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  type        = string
  default     = "AzureServices" 

  validation {
    condition = contains(["AzureServices", "None" ], var.key_vault_bypass)
    error_message = "The valut of the bypass property of the key vault is invalid."
  }
}

variable "key_vault_default_action" { 
  description = "(Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  type        = string
  default     = "Allow" 

  validation {
    condition = contains(["Allow", "Deny" ], var.key_vault_default_action)
    error_message = "The value of the default action property of the key vault is invalid."
  }
}

variable "admin_username" {
  description = "(Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "(Required) Specifies the SSH public key for the jumpbox virtual machine and AKS worker nodes."
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQbMSkHMxzXHcuXAbEQk2ELUj52jLa3yI73jcyIvyay4U65uhtnaResw3uXljsMb1ppbFwCFHC7+cNE1WNAI0+/raMka0SbCnC06sZsE78qaNrq3tw7WdnSGfLAMzJTIIQmwA8MxgI6GMw9Sfv++lr2c7ykO2xQL8bx6MI1XewSuHQlq79hWcNQU62kpZLQdKHsOlOx6weaXZxm/3Sb+Q/vno1fasjo5gha3FViBfGxKDJb/1Fizt9ZqcBPMbeEM+h7WIoU29iZcZG4NPjOGGEEUv4enYEPGRmdhfq5GPw5amCL+SQHFaCT1uRVwKzvwm+3tTc4YOL6PITB7mh/f632fDJprZisS7RAQh4EXqObWdoDIzQyz1py30rXIVe/x5phIs79IAtdtJzxQYRbqGkqUvOUi/ozKlylDHkhrr5gKZFRo0S6CRtqzoosFBU4fMQDCT+q3VJPo2T5yXqEipvbYKakIGDq7xFVHWd1/Ofc+R/xDp63zKnmEO0l3E0s70= peter@surface-laptop"
}

variable "keda_enabled" {
  description = "(Optional) Specifies whether KEDA Autoscaler can be used for workloads."
  type        = bool
  default     = false
}

variable "vertical_pod_autoscaler_enabled" {
  description = "(Optional) Specifies whether Vertical Pod Autoscaler should be enabled."
  type        = bool
  default     = true
}

variable "workload_identity_enabled" {
  description = "(Optional) Specifies whether Microsoft Entra ID Workload Identity should be enabled for the Cluster. Defaults to false."
  type        = bool
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "(Optional) Enable or Disable the OIDC issuer URL."
  type        = bool
  default     = true
}

variable "open_service_mesh_enabled" {
  description = "(Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS."
  type        = bool
  default     = false
}

variable "image_cleaner_enabled" {
  description = "(Optional) Specifies whether Image Cleaner is enabled."
  type        = bool
  default     = false
}

variable "azure_policy_enabled" {
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service"
  type        = bool
  default     = true
}

variable "http_application_routing_enabled" {
  description = "(Optional) Should HTTP Application Routing be enabled?"
  type        = bool
  default     = false
}

variable "default_node_pool_node_labels" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

variable "default_node_pool_node_taints" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = list(string)
  default       = []
} 

variable "private_cluster_enabled" {
  description = "Define if cluster is private or public"
  type        = bool
  default     = true
}

variable "k8s_service_name" {
  description = "(Required) Specifies the name of the Kubernetes service."
  default = "lb-internal-service"
  type        = string
}

variable "azure_load_balancer_internal" {
  description = "(Optional) Specifies whether the service is internal or not."
  default     = true
  type        = bool
}

variable "azure_load_balancer_internal_subnet" {
  description = "(Optional) Specifies the subnet name for the internal load balancer."
  default     = "subnet-lb"  
  type        = string
}

variable "azure_pls_create" {
  description = "(Optional) Specifies whether the service is internal or not."
 default     = true
  type        = bool
}

variable "k8s_service_port" {
  description = "(Optional) Specifies the port of the Kubernetes service."
  default     = "8080"
  type        = string
}

variable "k8s_service_target_port" {
  description = "(Optional) Specifies the target port of the Kubernetes service."
  default     = "80"
  type        = string
}

variable "k8s_service_type" {
  description = "(Optional) Specifies the type of the Kubernetes service."
  default     = "LoadBalancer"
  type        = string
}