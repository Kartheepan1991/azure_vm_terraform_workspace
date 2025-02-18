variable "environment" {
  description = "The environment (dev, stage, prod)"
  type        = string
}

variable "location" {
  description = "Azure region for the deployment"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the VM"
  type        = string
  sensitive   = true
}
