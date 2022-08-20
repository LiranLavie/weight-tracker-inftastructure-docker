variable "resource_group_name" {
  default     = "private_acr_group"
  type        = string
  description = "name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "acr_name" {
  type        = string
  description = "Name of the ACR."
}

variable "acr_sku" {
  default     = "Premium"
  type        = string
  description = "ACR sku"
}

variable "public_network_access_enabled" {
  default     = false
  type        = string
  description = "allow public network access"
}


variable "admin_enabled" {
  default     = true
  type        = string
  description = "allow admin"
}

variable "endpoint_name" {
  type        = string
  description = "ACR endpoint name"
}

variable "endpoint_config_name" {
  default     = "endpoint-nic-conf"
  type        = string
  description = "ACR endpoint config name"
}

variable "endpoint_network_interface_name" {
  type        = string
  description = "ACR endpoint network interface name"
}



variable "private_ip_address_allocation" {
  default     = "Dynamic"
  type        = string
  description = "Private ip address allocation"
}

variable "acr_dns_zone_name" {
  type        = string
  description = "Acr dns zone name"
}

variable "acr_vnet_name" {
  type        = string
  description = "Acr vnet name"
}

variable "acr_vnet_address_space" {
  type        = string
  description = "Acr vnet address space"
}

variable "acr_subnet_name" {
  type        = string
  description = "Acr subnet name"
}

variable "acr_subnet_address_prefix" {
  type        = string
  description = "Acr subnet address prefix"
}


variable "enforce_private_link_endpoint_network_policies" {
  default     = false
  type        = string
  description = "Allow private link endpoint network policies"
}

variable "acr_zone_net_link_name" {
  default     = "acr-zone-link"
  type        = string
  description = "Acr zone net link name"
}
variable "private_service_connection_name" {
  default     = "acr-private-endpoint-connection"
  type        = string
  description = "Acr private service connection name"
}

variable "is_manual_connection" {
  default     = false
  type        = string
  description = "Allow manual connection"
}

variable "private_service_connection_subresource_name" {
  default     = "registry"
  type        = string
  description = "Acr private service connection subresource name"
}

variable "private_dns_a_record_zone_name" {
  type        = string
  description = "Acr private dns A record zone name"
}

variable "private_dns_a_record_ttl" {
  default     = 300
  type        = string
  description = "Acr private dns TTL"
}







