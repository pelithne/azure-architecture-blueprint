// This block defines a variable for the resource group name of the virtual machine.
variable resource_group_name {
  description = "(Required) Specifies the resource group name of the virtual machine"
  type = string
}

// This block defines a variable for the name of the virtual machine.
variable name {
  description = "(Required) Specifies the name of the virtual machine"
  type = string
}

// This block defines a variable for the size of the virtual machine.
variable size {
  description = "(Required) Specifies the size of the virtual machine"
  type = string
}

// This block defines a variable for the OS disk image of the virtual machine.
variable "os_disk_image" {
  type        = map(string)
  description = "(Optional) Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2" 
    version   = "latest"
  }
}

// This block defines a variable for the storage account type of the OS disk of the virtual machine.
variable "os_disk_storage_account_type" {
  description = "(Optional) Specifies the storage account type of the os disk of the virtual machine"
  default     = "StandardSSD_LRS"
  type        = string

  validation {
    condition = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS",  "Standard_LRS"], var.os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid."
  }
}

// This block defines a variable for whether to create a public IP for the virtual machine.
variable public_ip {
  description = "(Optional) Specifies whether create a public IP for the virtual machine"
  type = bool
  default = false
}

// This block defines a variable for the location of the virtual machine.
variable location {
  description = "(Required) Specifies the location of the virtual machine"
  type = string
}

// This block defines a variable for the DNS domain name of the virtual machine.
variable domain_name_label {
  description = "(Required) Specifies the DNS domain name of the virtual machine"
  type = string
}

// This block defines a variable for the resource id of the subnet hosting the virtual machine.
variable subnet_id {
  description = "(Required) Specifies the resource id of the subnet hosting the virtual machine"
  type        = string
}

// This block defines a variable for the username of the virtual machine.
variable vm_user {
  description = "(Required) Specifies the username of the virtual machine"
  type        = string
  default     = "azadmin"
}

// This block defines a variable for the primary/secondary endpoint for the Azure Storage Account which should be used to store boot diagnostics.
variable "boot_diagnostics_storage_account" {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

// This block defines a variable for the tags of the storage account.
variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}

// This block defines a variable for the log analytics workspace id.
variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}

// This block defines a variable for the log analytics workspace key.
variable "log_analytics_workspace_key" {
  description = "Specifies the log analytics workspace key"
  type        = string
}

// This block defines a variable for the log analytics workspace resource id.
variable "log_analytics_workspace_resource_id" {
  description = "Specifies the log analytics workspace resource id"
  type        = string
}

// This block defines a variable for the public SSH key.
variable "admin_ssh_public_key" {
  description = "Specifies the public SSH key"
  type        = string
}

// The following blocks are commented out. If uncommented, they would define variables for the storage account and container that contain a custom script, and the name of the custom script.
/*
variable "script_storage_account_name" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "script_storage_account_key" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "container_name" {
  description = "(Required) Specifies the name of the container that contains the custom script."
  type        = string
}

variable "script_name" {
  description = "(Required) Specifies the name of the custom script."
  type        = string
}
*/