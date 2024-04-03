# This variable is used to specify the resource group name of the storage account.
variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the storage account"
  type        = string
}

# This variable is used to specify the name of the storage account.
variable "name" {
  description = "(Required) Specifies the name of the storage account"
  type        = string
}

# This variable is used to specify the location of the storage account.
variable "location" {
  description = "(Required) Specifies the location of the storage account"
  type        = string
}

# This variable is used to specify the account kind of the storage account. It defaults to "StorageV2".
variable "account_kind" {
  description = "(Optional) Specifies the account kind of the storage account"
  default     = "StorageV2"
  type        = string

  # This block validates that the account kind is either "Storage" or "StorageV2".
  validation {
    condition = contains(["Storage", "StorageV2"], var.account_kind)
    error_message = "The account kind of the storage account is invalid."
  }
}

# This variable is used to specify the account tier of the storage account. It defaults to "Standard".
variable "account_tier" {
  description = "(Optional) Specifies the account tier of the storage account"
  default     = "Standard"
  type        = string

  # This block validates that the account tier is either "Standard" or "Premium".
  validation {
    condition = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account tier of the storage account is invalid."
  }
}

# This variable is used to specify the replication type of the storage account. It defaults to "LRS".
variable "replication_type" {
  description = "(Optional) Specifies the replication type of the storage account"
  default     = "LRS"
  type        = string

  # This block validates that the replication type is one of the allowed values.
  validation {
    condition = contains(["LRS", "ZRS", "GRS", "GZRS", "RA-GRS", "RA-GZRS"], var.replication_type)
    error_message = "The replication type of the storage account is invalid."
  }
}

# This variable is used to specify whether Hierarchical Namespace (HNS) is enabled for the storage account. It defaults to false.
variable "is_hns_enabled" {
  description = "(Optional) Specifies the replication type of the storage account"
  default     = false
  type        = bool
}

# This variable is used to specify the default action for public access to all blobs or containers in the storage account. It defaults to "Allow".
variable "default_action" {
    description = "Allow or disallow public access to all blobs or containers in the storage accounts. The default interpretation is true for this property."
    default     = "Allow"
    type        = string  
}

# This variable is used to specify IP rules for the storage account.
variable "ip_rules" {
    description = "Specifies IP rules for the storage account"
    default     = []
    type        = list(string)  
}

# This variable is used to specify a list of resource ids for subnets.
variable "virtual_network_subnet_ids" {
    description = "Specifies a list of resource ids for subnets"
    default     = []
    type        = list(string)  
}

# This variable is used to specify the kind of the storage account.
variable "kind" {
  description = "(Optional) Specifies the kind of the storage account"
  default     = ""
}

# This variable is used to specify the tags of the storage account.
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}