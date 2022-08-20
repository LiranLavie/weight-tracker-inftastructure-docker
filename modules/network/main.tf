# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

# Create public subnet
resource "azurerm_subnet" "public_subnet" {
  name                 = "${var.public_subnet_name}-${terraform.workspace}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_prefix]
}

# Create private subnet
resource "azurerm_subnet" "private_subnet" {
  name                 = "${var.private_subnet_name}-${terraform.workspace}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_address_prefix]
# grant the PaaS service DBforPostgreSQL to control certain aspects of a subnet, within an existing VNet
  delegation{
     name = var.private_subnet_delegation_name
     service_delegation {name = var.private_subnet_service_delegation}
  }
}


 # Create public ip for load balancer
resource "azurerm_public_ip" "web_srv_lb_ip" {
   name                         = "${var.web_srv_lb_ip_name}-${terraform.workspace}"
   location                     = var.resource_group_location
   resource_group_name          = var.resource_group_name
   allocation_method            = var.lb_ip_allocation_method
   sku = var.lb_sku
 }


# Create Network Security Group and rules for public subnet
resource "azurerm_network_security_group" "public_subnet_ngs" {
  name                = "${var.public-subnet-ngs_name}-${terraform.workspace}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.host_ip_address
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Port_8080"
    priority                   = 1400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowVnetInBound"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "DenyAllInBound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create Network Security Group and rules for private subnet
resource "azurerm_network_security_group" "private_subnet_ngs" {
  name                = "${var.private-subnet-ngs_name}-${terraform.workspace}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Port_5432"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.public_subnet_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyAllInBound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the security group to the public subnet
resource "azurerm_subnet_network_security_group_association" "public-subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.public_subnet_ngs.id
}

# Associate the security group to the private subnet
resource "azurerm_subnet_network_security_group_association" "private-subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_subnet_ngs.id
}