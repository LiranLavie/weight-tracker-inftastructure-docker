output "admin_username" {
  value       = azurerm_linux_virtual_machine.agent-vm.admin_username
  description = "output admin username for ansible inventory template"
}

output "agent_name" {
  value       = azurerm_linux_virtual_machine.agent-vm.name
  description = "output agent name for ansible inventory template"
}

output "admin_password" {
  value       = azurerm_linux_virtual_machine.agent-vm.admin_password
  description = "output admin password for ansible inventory template"
}

output "agent_public_ip_address" {
  value       = azurerm_public_ip.agent_public_ip.ip_address
  description = "output agent_public_ip_address for ansible inventory template"
}
