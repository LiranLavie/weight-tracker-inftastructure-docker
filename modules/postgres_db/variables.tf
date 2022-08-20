variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group."
}

variable "vnet_id" {
  type        = string
  description = "Virtual network id."
}

variable "private_subnet_id" {
  type        = string
  description = "Virtual network id."
}

variable "postgres_username" {
  description = "postgres username set in variables.tfvars for security reasons."
}
variable "postgres_password" {
  description = "postgres password set in variables.tfvars for security reasons."
}

variable "firewall_rule_start_ip" {
  description = "Firewall rule to start from this ip."
}

variable "firewall_rule_end_ip" {
  description = "Firewall rule to end with this ip."
}

variable "postgres_dns_zone_name" {
  default     = "postgres.database.azure.com"
  description = "Postgres dns zone name"
}

variable "private_dns_zone_virtual_network_link_name" {
  default     = "postgres-zone-net-link"
  description = "Postgres private dns zone virtual network link name"
}

variable "postgres_server_name" {
  default     = "postgresflex"
  description = "Postgres server name"
}

variable "postgres_server_version" {
  default     = 12
  description = "Postgres server version"
}

variable "postgres_zone" {
  default     = 1
  description = "Postgres zone"
}

variable "postgres_storage_mb" {
  default     = 32768
  description = "Postgres storage in mb"
}

variable "postgres_sku_name" {
  default     = "B_Standard_B1ms"
  description = "Postgres sku name"
}

variable "postgres_config_name" {
  default     = "require_secure_transport"
  description = "Postgres server configuration name"
}

variable "secure_transport_config_value" {
  default     = "OFF"
  description = "Postgres secure transport configuration value"
}

variable "postgres_firewall_rule_name" {
  default     = "postgres_access_rule"
  description = "Postgres firewall rule name"
}




