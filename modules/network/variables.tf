variable "resource_group_name" {
  type        = string
  description = "name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "vnet_name" {
  type        = string
  description = "Vnet name."
}
variable "vnet_address_space" {
  type        = string
  description = "Vnet address."
}

variable "public_subnet_name" {
  type        = string
  description = "Public subnet name."
}

variable "private_subnet_name" {
  type        = string
  description = "Private subnet name."
}
variable "public_subnet_address_prefix" {
  type        = string
  description = "Public subnet address prefix."
}

variable "private_subnet_address_prefix" {
  type        = string
  description = "Private subnet address prefix."
}

variable "private_subnet_delegation_name" {
  default     = "postgreSQL-delegate"
  type        = string
  description = "Private subnet delegation name."
}

variable "private_subnet_service_delegation" {
  default     = "Microsoft.DBforPostgreSQL/flexibleServers"
  type        = string
  description = "Private subnet service_delegation."
}

variable "web_srv_lb_ip_name" {
  default     = "lb-public-ip"
  type        = string
  description = "Load Balancer ip name."
}

variable "lb_ip_allocation_method" {
  default     = "Static"
  type        = string
  description = "Load Balancer ip allocation method."
}

variable "lb_sku" {
  default     = "Standard"
  type        = string
  description = "Load Balancer sku"
}

variable "public-subnet-ngs_name" {
  type        = string
  description = "Name of public subnet NSG"
}

variable "private-subnet-ngs_name" {
  type        = string
  description = "Name of private subnet NSG"
}

variable "host_ip_address" {
  type        = string
  description = "Host ip address"
}
