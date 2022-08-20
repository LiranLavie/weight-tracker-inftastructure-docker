# Create postgres DNS zone
resource "azurerm_private_dns_zone" "postgres_dns_zone" {
  name                = "${terraform.workspace}.${var.postgres_dns_zone_name}"
  resource_group_name = var.resource_group_name
}

# Link DNS zone to virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_zone_net_link" {
  name                  = "${var.private_dns_zone_virtual_network_link_name}-${terraform.workspace}"
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns_zone.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}

# Create postgresql flexible server
resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                   = "${var.postgres_server_name}-${terraform.workspace}"
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  version                = var.postgres_server_version
  delegated_subnet_id    = var.private_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.postgres_dns_zone.id
  administrator_login    = var.postgres_username
  administrator_password = var.postgres_password
  zone                   = var.postgres_zone
  storage_mb = var.postgres_storage_mb
  sku_name   = var.postgres_sku_name
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_zone_net_link]

}

# Disable SSL auth on postgres server
resource "azurerm_postgresql_flexible_server_configuration" "postgresql_server_conf" {
  name      = var.postgres_config_name
  server_id = azurerm_postgresql_flexible_server.postgres_server.id
  value     = var.secure_transport_config_value
}

#Add postgres firewall rule
resource "azurerm_postgresql_flexible_server_firewall_rule" "posgres_firewall_rule" {
  name             = "${var.postgres_firewall_rule_name}-${terraform.workspace}"
  server_id        = azurerm_postgresql_flexible_server.postgres_server.id
  start_ip_address = var.firewall_rule_start_ip
  end_ip_address   = var.firewall_rule_end_ip
}