# Create webserver load balancer
resource "azurerm_lb" "web_server_lb" {
   name                = "${var.web_server_lb_name}-${terraform.workspace}"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name
   sku                 = var.lb_sku

   frontend_ip_configuration {
     name                 = "${var.lb_ip_conf_name}-${terraform.workspace}"
     public_ip_address_id = var.lb_public_ip_id
   }
 }

# Create webserver load balancer address pool
resource "azurerm_lb_backend_address_pool" "webserver_lb_pool" {
   loadbalancer_id     = azurerm_lb.web_server_lb.id
   name                = "${var.lb_pool_name}-${terraform.workspace}"
 }

# Add load balancer rule
 resource "azurerm_lb_rule" "web_srv_lb_rule_8080" {
   resource_group_name            = var.resource_group_name
   # The port used for internal connections on the endpoint.
   backend_port                   = 8080
   frontend_ip_configuration_name = azurerm_lb.web_server_lb.frontend_ip_configuration[0].name
   # The port for the external endpoint.
   frontend_port                  = 8080
   loadbalancer_id                = azurerm_lb.web_server_lb.id
   name                           = "Port_8080"
   protocol                       = "Tcp"
   backend_address_pool_ids = [azurerm_lb_backend_address_pool.webserver_lb_pool.id]
 }

resource "azurerm_network_interface_backend_address_pool_association" "network_pool_association" {
  count                   = var.vm_count
  backend_address_pool_id = azurerm_lb_backend_address_pool.webserver_lb_pool.id
  ip_configuration_name   = "web-server${count.index+1}-nic-conf-${terraform.workspace}"
  network_interface_id    = var.web_server_nic_id[count.index]
}


# Create webserver load balancer health probe,check if instance is healthy and can receive traffic.
resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id = azurerm_lb.web_server_lb.id
  name            = "${var.lb_probe_name}-${terraform.workspace}"
  port            = var.lb_probe_port
  protocol        = var.lb_probe_protocol
  request_path    = var.lb_probe_request_path
}
