variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "aks-resource-group"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-cluster"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "aks-cluster"
}

variable "storage_account_name" {
  description = "Name of the storage account for Terraform state"
  type        = string
  default     = "onlinestoretfstate"
}

variable "terraform_container_name" {
  description = "Name of the Terraform state container"
  type        = string
  default     = "terraform"
}

variable "terraform_state_key" {
  description = "Key for Terraform state file"
  type        = string
  default     = "terraform.tfstate"
}

variable "terraform_resource_group" {
  description = "Resource group for Terraform state storage"
  type        = string
  default     = "online-store-terraform-state"
}
