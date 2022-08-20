# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${terraform.workspace}"
  location = var.resource_group_location
}

#Init network module
module "network" {
  source = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space
  public_subnet_name = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  public-subnet-ngs_name = var.public-subnet-ngs_name
  private-subnet-ngs_name = var.private-subnet-ngs_name
  public_subnet_address_prefix = var.public_subnet_prefix
  private_subnet_address_prefix = var.private_subnet_prefix
  host_ip_address = var.host_ip_address
}

# Init network module
module "private_acr" {
  source = "./modules/acr"
  acr_name = var.acr_name
  resource_group_location = azurerm_resource_group.rg.location
  acr_vnet_name = var.acr_vnet_name
  acr_vnet_address_space = var.acr_vnet_address_space
  acr_subnet_name = var.acr_subnet_name
  acr_subnet_address_prefix = var.acr_subnet_address_prefix
  acr_dns_zone_name = var.acr_dns_zone_name
  endpoint_name = var.endpoint_name
  endpoint_network_interface_name = var.endpoint_network_interface_name
  private_dns_a_record_zone_name = var.private_dns_a_record_zone_name
}

# Init web servers cluster module
module "servers_cluster" {
  source                  = "./modules/web_server"
  vm_count                = var.server_count
  availability_set_name   = "${var.availability_set_name}-${terraform.workspace}"
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  server_name             = var.web_server_name
  subnet_id               = module.network.public_subnet_id
  username                = var.webserver_username
  password                = var.webserver_password
}

module "azure_devops_agents" {
  source = "./modules/agent"
  agent_name = "${var.agent_vm_name}-${terraform.workspace}"
  password = var.webserver_password
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.network.public_subnet_id
  username = var.webserver_username
}

#Init load balancer module
module "server_load_balancer" {
  source         = "./modules/load_balancer"
  vm_count = var.server_count
  lb_public_ip_id = module.network.lb_ip_id
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  web_server_nic_id = module.servers_cluster.web_server_nic_id
  web_server_nic_ip_conf_name = module.servers_cluster.web_server_nic_ipconf_name
}

#Init postgres module
module "postgres_server" {
  source = "./modules/postgres_db"
  firewall_rule_end_ip = var.postgres_firewall_rule_end_ip
  firewall_rule_start_ip = var.postgres_firewall_rule_start_ip
  postgres_password = var.postgres_password
  postgres_username = var.postgres_username
  private_subnet_id = module.network.private_subnet_id
  resource_group_location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_id = module.network.vnet_id
}










