variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group."
}

variable "vm_count" {
  default     = 1
  type        = number
  description = "How many Vms to create"
}

variable "subnet_id" {
  type        = string
  description = "Network subnet id"
}

variable "availability_set_name" {
  type        = string
  description = "Name of vailability set"
}

variable "server_name" {
  type        = string
  description = "Name of server"
}

variable "username" {
  type        = string
  description = "Admin username"
}
variable "password" {
  type        = string
  description = "Admin password"
}

variable "private_ip_address_allocation" {
  default     = "Dynamic"
  type        = string
  description = "Type of private_ip_address_allocation"
}

variable "enable_managed_availability_set" {
  default     = true
  type        = bool
  description = "Allow managed availability set"
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





