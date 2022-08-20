variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group."
}

variable "subnet_id" {
  type        = string
  description = "Network subnet id."
}


variable "agent_name" {
  type        = string
  description = "Name of agent."
}

variable "username" {
  type        = string
  description = "Admin username."
}
variable "password" {
  type        = string
  description = "Admin password."
}



variable "vm_size" {
  default     = "Standard_B1s"
  type        = string
  description = "Virtual machine size"
}

variable "disable_password_authentication" {
  default     = false
  type        = bool
  description = "Disable password authentication"
}

variable "disk_caching" {
  default     = "ReadWrite"
  type        = string
  description = "Disk caching option"
}

variable "storage_account_type" {
  default     = "Standard_LRS"
  type        = string
  description = "Storage Account Type"
}

variable "image_publisher" {
  default     = "Canonical"
  type        = string
  description = "Image publisher"
}

variable "image_offer" {
  default     = "UbuntuServer"
  type        = string
  description = "Image offer"
}

variable "image_sku" {
  default     = "18.04-LTS"
  type        = string
  description = "Image sku"
}

variable "image_version" {
  default     = "latest"
  type        = string
  description = "Image version"
}

variable "agent_ip_allocation_method" {
  default     = "Static"
  type        = string
  description = "agent public ip allocation method."
}

variable "public_ip_sku" {
  default     = "Standard"
  type        = string
  description = "Agent public ip sku"
}

variable "public_ip_name" {
  default     = "agent-public-ip"
  type        = string
  description = "Agent public ip name"
}

variable "agent_nic_name" {
  default     = "agent-nic_name"
  type        = string
  description = "Agent network name"
}

variable "agent_ip_conf_name" {
  default     = "agent--nic-conf"
  type        = string
  description = "Agent ip configuration name"
}

variable "private_ip_address_allocation" {
  default     = "Dynamic"
  type        = string
  description = "Type of private_ip_address_allocation"
}

variable "agent_vm_name" {
  default     = "agent"
  type        = string
  description = "Name of azure devops agent virtual machine"
}







