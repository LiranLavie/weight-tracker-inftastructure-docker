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
  description = "How many Vms to add."
}

variable "lb_public_ip_id" {
  type        = string
  description = "Load balancer public ip id."
}

variable "web_server_nic_id" {
  description = "Web server nic id."
}

variable "web_server_nic_ip_conf_name" {
  description = "Wen server nic IP configuration"
}

variable "web_server_lb_name" {
  default     = "web-server-lb"
  description = "Load Balancer name"
}

variable "lb_sku" {
  default     = "Standard"
  description = "Load Balancer sku"
}

variable "lb_ip_conf_name" {
  default     = "lb-public-ip-conf"
  description = "Load Balancer ip configuration name"
}

variable "lb_pool_name" {
  default     = "webserver-lb-pool"
  description = "Load Balancer pool name"
}

variable "lb_probe_name" {
  default     = "web-server-lb-probe"
  description = "Load Balancer probe name"
}

variable "lb_probe_port" {
  default     = 8080
  description = "Load Balancer probe port"
}

variable "lb_probe_protocol" {
  default     = "HTTP"
  description = "Load Balancer probe protocol"
}

variable "lb_probe_request_path" {
  default     = "/"
  description = "Load Balancer probe request path"
}


