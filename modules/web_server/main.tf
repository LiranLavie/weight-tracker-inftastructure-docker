#Module for creating webserver VMs

# Create network interface
resource "azurerm_network_interface" "web_server_nic" {
  count = var.vm_count
  name                = "web-server${count.index+1}-network-interface-${terraform.workspace}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "web-server${count.index+1}-nic-conf-${terraform.workspace}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

# Create availability set
resource "azurerm_availability_set" "web_server_avset" {
   name                         = var.availability_set_name
   location                     = var.resource_group_location
   resource_group_name          = var.resource_group_name
   platform_fault_domain_count  = var.vm_count
   platform_update_domain_count = var.vm_count
   managed                      = var.enable_managed_availability_set
 }

# Create virtual machines
resource "azurerm_linux_virtual_machine" "web-server-vm" {
  count = var.vm_count
  name                = "${var.server_name}-${count.index+1}-${terraform.workspace}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  availability_set_id = azurerm_availability_set.web_server_avset.id
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [azurerm_network_interface.web_server_nic[count.index].id]
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



