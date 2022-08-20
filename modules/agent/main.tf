#Module for creating agent VMs

# Create network interface
resource "azurerm_network_interface" "agent_server_nic" {
  name                = "${var.agent_nic_name}-${terraform.workspace}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.agent_ip_conf_name}-${terraform.workspace}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id = azurerm_public_ip.agent_public_ip.id
  }
}

 # Create public ip for agent
resource "azurerm_public_ip" "agent_public_ip" {
   name                         = "${var.public_ip_name}-${terraform.workspace}"
   location                     = var.resource_group_location
   resource_group_name          =  var.resource_group_name
   allocation_method            = var.agent_ip_allocation_method
   sku = var.public_ip_sku
 }

# Create virtual machines
resource "azurerm_linux_virtual_machine" "agent-vm" {
  name                = "${var.agent_vm_name}-${terraform.workspace}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [azurerm_network_interface.agent_server_nic.id]
  disable_password_authentication = var.disable_password_authentication


  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}



