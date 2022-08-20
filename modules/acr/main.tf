# Private ACR Modules

# Create resource group
resource "azurerm_resource_group" "acr_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Create azure container registry
resource "azurerm_container_registry" "private-acr" {
  location            = var.resource_group_location
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.acr_rg.name
  sku                 = var.acr_sku
  public_network_access_enabled = var.public_network_access_enabled
  admin_enabled = var.admin_enabled
}

resource "azurerm_network_interface" "endpoint_network_interface" {
  location            = var.resource_group_location
  name                = var.endpoint_network_interface_name
  resource_group_name = azurerm_resource_group.acr_rg.name
  ip_configuration {
    name                          = var.endpoint_config_name
    subnet_id                     = azurerm_subnet.acr_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

## Create private DNS zone
resource "azurerm_private_dns_zone" "acr_dns_zone" {
  name                = var.acr_dns_zone_name
  resource_group_name = azurerm_resource_group.acr_rg.name
}
#
# Create virtual network
resource "azurerm_virtual_network" "acr_vnet" {
  name                = var.acr_vnet_name
  address_space       = [var.acr_vnet_address_space]
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.acr_rg.name
}

# Create a subnet
resource "azurerm_subnet" "acr_subnet" {
  name                 = var.acr_subnet_name
  resource_group_name  = azurerm_resource_group.acr_rg.name
  virtual_network_name = azurerm_virtual_network.acr_vnet.name
  address_prefixes     = [var.acr_subnet_address_prefix]
  #Allow network policies for a subnet in a virtual network.
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
}

# Link DNS zone to virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "acr_zone_net_link" {
  name                  = var.acr_zone_net_link_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.acr_vnet.id
  resource_group_name   = azurerm_resource_group.acr_rg.name
}

#Create a private registry endpoint
resource "azurerm_private_endpoint" "private_endpoint" {
  location            = var.resource_group_location
  name                = var.endpoint_name
  resource_group_name = azurerm_resource_group.acr_rg.name
  subnet_id           = azurerm_subnet.acr_subnet.id

  private_service_connection {
    # Does the Private Endpoint require Manual Approval from the remote resource owner
    is_manual_connection = var.is_manual_connection
    name                 = var.private_service_connection_name
    private_connection_resource_id = azurerm_container_registry.private-acr.id
    # A list of subresource names which the Private Endpoint is able to connect to.
    subresource_names = [var.private_service_connection_subresource_name]
  }
}

resource "azurerm_private_dns_a_record" "private_dns_a_record" {
  name                = azurerm_container_registry.private-acr.name
  zone_name           = var.private_dns_a_record_zone_name
  resource_group_name = azurerm_resource_group.acr_rg.name
  ttl                 = var.private_dns_a_record_ttl
  records             = [azurerm_network_interface.endpoint_network_interface.private_ip_address]
}
