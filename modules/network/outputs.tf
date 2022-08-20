output "public_subnet_id" {
  value       = azurerm_subnet.public_subnet.id
  description = "Public subnet id"
}

output "private_subnet_id" {
  value       = azurerm_subnet.private_subnet.id
  description = "Private subnet id"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virtual network id"
}

output "lb_ip_id" {
  value       = azurerm_public_ip.web_srv_lb_ip.id
  description = "Load Balancer ip id"
}

output "lb_ip_address" {
  value       = azurerm_public_ip.web_srv_lb_ip.ip_address
  description = "Load Balancer ip address"
}
