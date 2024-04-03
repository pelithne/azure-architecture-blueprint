# This block declares a variable named "name" which specifies the name of the node pool.
variable "name" {
  description = "(Required) Specifies the name of the node pool."
  type        = string
}

# This block declares a variable named "kubernetes_cluster_id" which specifies the resource id of the AKS cluster.
variable "kubernetes_cluster_id" {
  description = "(Required) Specifies the resource id of the AKS cluster."
  type        = string
}

# This block declares a variable named "vm_size" which specifies the SKU for the Virtual Machines used in this Node Pool.
variable "vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
}

# This block declares a variable named "availability_zones" which specifies a list of Availability Zones where the Nodes in this Node Pool should be created in.
variable "availability_zones" {
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
  type        = list(string)
  default = ["1", "2", "3"]
}

# This block declares a variable named "enable_auto_scaling" which specifies whether to enable auto-scaler.
variable "enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type          = bool
  default       = false
}

# This block declares a variable named "enable_host_encryption" which specifies whether the nodes in this Node Pool should have host encryption enabled.
variable "enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type          = bool
  default       = false
} 

# This block declares a variable named "enable_node_public_ip" which specifies whether each node should have a Public IP Address.
variable "enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type          = bool
  default       = false
} 

# This block declares a variable named "max_pods" which specifies the maximum number of pods that can run on each agent.
variable "max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type          = number
  default       = 250
}

# This block declares a variable named "mode" which specifies whether this Node Pool should be used for System or User resources.
variable "mode" {
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
  type          = string
  default       = "User"
} 

# This block declares a variable named "node_labels" which specifies a map of Kubernetes labels which should be applied to nodes in this Node Pool.
variable "node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

# This block declares a variable named "node_taints" which specifies a list of Kubernetes taints which should be applied to nodes in the agent pool.
variable "node_taints" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = list(string)
  default       = []
} 

# This block declares a variable named "tags" which specifies the tags of the network security group.
variable "tags" {
  description = "(Optional) Specifies the tags of the network security group"
  default     = {}
}

# This block declares a variable named "orchestrator_version" which specifies the version of Kubernetes used for the Agents.
variable "orchestrator_version" {
  description = "(Optional) Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
  type          = string
  default       = null
} 

# This block declares a variable named "os_disk_size_gb" which specifies the Agent Operating System disk size in GB.
variable "os_disk_size_gb" {
  description = "(Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
  type          = number
  default       = null
} 

# This block declares a variable named "os_disk_type" which specifies the type of disk which should be used for the Operating System.
variable "os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type          = string
  default       = "Managed"
} 

# This variable is used to specify the operating system for the Node Pool. It can be either Linux or Windows. By default, it is set to Linux.
variable "os_type" {
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
  type          = string
  default       = "Linux"
} 

# This variable is used to specify the operating system for the Node Pool. It can be either Linux or Windows. By default, it is set to Linux.
variable "priority" {
  description = "(Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  type          = string
  default       = "Regular"
} 

# This variable is used to specify the ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers the Node Pool will be placed.  
variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers this Node Pool will be placed. Changing this forces a new resource to be created."
  type          = string
  default       = null
} 

# This variable is used to specify the ID of the Subnet where the Node Pool should exist.
variable "vnet_subnet_id" {
  description = "(Optional) The ID of the Subnet where this Node Pool should exist."
  type          = string
  default       = null
}

# This variable is used to specify the ID of the Subnet where the pods in the default Node Pool should exist.
variable "pod_subnet_id" {
  description = "(Optional) The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created."
  type          = string
  default       = null
}


# This variable is used to specify the maximum number of nodes that should exist within the Node Pool. The valid values are between 0 and 1000 and it must be greater than or equal to min_count. By default, it is set to 10.
variable "max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 10
}


# This variable is used to specify the minimum number of nodes that should exist within the Node Pool. The valid values are between 0 and 1000 and it must be less than or equal to max_count. By default, it is set to 3.
variable "min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 3
}

# This variable is used to specify the initial number of nodes that should exist within the Node Pool. The valid values are between 0 and 1000 and it must be a value in the range min_count - max_count. By default, it is set to 3.
variable "node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 3
}


# This variable is used to enable or disable the OIDC issuer URL. By default, it is set to true.
variable "oidc_issuer_enabled" {
  description = " (Optional) Enable or Disable the OIDC issuer URL."
  type        = bool
  default     = true
}
