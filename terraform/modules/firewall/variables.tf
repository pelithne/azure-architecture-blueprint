# This variable specifies the name of the firewall.
variable "name" {
  description = "Specifies the firewall name"
  type        = string
}

# This variable specifies the SKU name of the firewall.
# It has a default value of "AZFW_VNet".
# It also includes a validation condition to ensure the value is either "AZFW_Hub" or "AZFW_VNet".
variable "sku_name" {
  description = "(Required) SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
  default     = "AZFW_VNet"
  type        = string

  validation {
    condition = contains(["AZFW_Hub", "AZFW_VNet" ], var.sku_name)
    error_message = "The value of the sku name property of the firewall is invalid."
  }
}

# This variable specifies the SKU tier of the firewall.
# It has a default value of "Standard".
# It also includes a validation condition to ensure the value is either "Premium", "Standard", or "Basic".
variable "sku_tier" {
  description = "(Required) SKU tier of the Firewall. Possible values are Premium, Standard, and Basic."
  default     = "Standard"
  type        = string

  validation {
    condition = contains(["Premium", "Standard", "Basic" ], var.sku_tier)
    error_message = "The value of the sku tier property of the firewall is invalid."
  }
}

# This variable specifies the name of the resource group.
variable "resource_group_name" {
  description = "Specifies the resource group name"
  type        = string
}

# This variable specifies the location where the firewall will be deployed.
variable "location" {
  description = "Specifies the location where firewall will be deployed"
  type        = string
}

# This variable specifies the operation mode for threat intelligence-based filtering.
# It has a default value of "Alert".
# It also includes a validation condition to ensure the value is either "Off", "Alert", or "Deny".
variable "threat_intel_mode" {
  description = "(Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny. Defaults to Alert."
  default     = "Alert"
  type        = string

  validation {
    condition = contains(["Off", "Alert", "Deny"], var.threat_intel_mode)
    error_message = "The threat intel mode is invalid."
  }
}

# This variable specifies the availability zones of the Azure Firewall.
# It has a default value of ["1", "2", "3"].
variable "zones" {
  description = "Specifies the availability zones of the Azure Firewall"
  default     = ["1", "2", "3"]
  type        = list(string)
}

# This variable specifies the name of the firewall public IP.
# It has a default value of "azure-fw-ip".
variable "pip_name" {
  description = "Specifies the firewall public IP name"
  type        = string
  default     = "azure-fw-ip"
}

# This variable specifies the ID of the subnet.
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

# This variable specifies the tags of the storage account.
# It has a default value of {}.
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}

# This variable specifies the ID of the log analytics workspace.
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}