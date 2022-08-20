# Resource Group Variables
variable "resource_group_name" {
  type        = string
  description = "name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}
variable "storage_rg_name" {
  type        = string
  description = "name of the storage resource group."
}

# Virtual Machine Variables
variable "server_count" {
  type        = number
  description = "How many Servers to create."
}

variable "webserver_username" {
  description = "Admin username set in variables.tfvars for security reasons."
}
variable "webserver_password" {
  description = "Admin password set in variables.tfvars for security reasons."
}

variable "availability_set_name" {
  type        = string
  description = "Name of availability set"
}

variable "web_server_name" {
  type        = string
  description = "Name of the web server"
}

variable "agent_vm_name" {
  type        = string
  description = "Name of the azure devops vm agent"
}

# Network Variables
variable "host_ip_address" {
  type        = string
  description = "host ip address to allow for ssh firewall rule,set in variables.tfvars for security reasons."
}
variable "vnet_address_space" {
  description = "Address space for a vnet"
}

variable "private_subnet_prefix" {
  description = "Set a prefix for private subnet"
}
variable "public_subnet_prefix" {
  description = "Set a prefix for public subnet"
}

variable "vnet_name" {
  type        = string
  description = "Vnet name."
}

variable "public_subnet_name" {
  type        = string
  description = "Public subnet name."
}

variable "private_subnet_name" {
  type        = string
  description = "Private subnet name."
}

variable "public-subnet-ngs_name" {
  type        = string
  description = "Name of public subnet NSG"
}

variable "private-subnet-ngs_name" {
  type        = string
  description = "Name of private subnet NSG"
}


# Postgres variables

variable "db_name" {
  description = "The name of postgres data base"
}

variable "postgres_firewall_rule_start_ip" {
  description = "The start ip address when allowing access to postgres through postgres firewall"
}

variable "postgres_firewall_rule_end_ip" {
  description = "The end ip address when allowing access to postgres through postgres firewall"
}

variable "okta_url" {
  description = "The the url for okta auth"
}

variable "okta_client_id" {
  description = "The client id for okta auth"
}

variable "okta_secret" {
  description = "The okta secret"
}

variable "container_reg_usr" {
  description = "Azure container registry username"
}

variable "container_reg_pass" {
  description = "Azure container registry password"
}

variable "postgres_username" {
  description = "postgres username set in variables.tfvars for security reasons."
}
variable "postgres_password" {
  description = "postgres password set in variables.tfvars for security reasons."
}


#Used when storing state remotely
variable "storage_account_key" {
  type        = string
  description = "key is stored in variables.tfvars for security reasons."
}


# ACR Variables
variable "acr_dns_zone_name" {
  type        = string
  description = "Acr dns zone name"
}

variable "acr_name" {
  type        = string
  description = "Name of the ACR."
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

variable "endpoint_name" {
  type        = string
  description = "ACR endpoint name"
}

variable "endpoint_network_interface_name" {
  type        = string
  description = "ACR endpoint network interface name"
}

variable "private_dns_a_record_zone_name" {
  type        = string
  description = "Acr private dns A record zone name"
}

# Storage Variables
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}
variable "storage_account_tier" {
  type        = string
  description = "Tier of the storage account"
}

variable "account_replication_type" {
  type        = string
  description = "Account replication type"
}

variable "storage_container_name" {
  type        = string
  description = "Name of the storage container"
}

variable "storage_container_access_type" {
  type        = string
  description = "Access type of the storage container"
}




