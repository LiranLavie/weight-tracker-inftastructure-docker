
# Create inventory host file for each workspace
resource "local_file" "ansible_agent_inventory" {
 content = templatefile("./templates/ansible-inventory-agents-template.tmpl",
   {
     group_name      = "webserver_${terraform.workspace}"
     webserver_names = module.servers_cluster.webserver_names
     private_ip      = module.servers_cluster.webserver_private_ips
     agent_name      = module.azure_devops_agents.agent_name
     agent_public_ip = module.azure_devops_agents.agent_public_ip_address
   })

  filename = pathexpand("~/ansible-agent/inventory/${terraform.workspace}/host")
}

# Create variables for webservers in production/staging for ansible.
resource "local_file" "ansible_agent_host_vars" {
  count = var.server_count
  content = templatefile("./templates/ansible-host-var-agents-template.tmpl",
   {
     ansible_user    = module.servers_cluster.admin_usernames[count.index]
     server_password = module.servers_cluster.admin_passwords[count.index]
     db_address      = "${module.postgres_server.postgres_db_name}.postgres.database.azure.com"

   })

  filename = pathexpand("~/ansible-agent/inventory/${terraform.workspace}/host_vars/${module.servers_cluster.webserver_names[count.index]}.yml")
}

# Create  variables files for azure devops agent
resource "local_file" "ansible_agent_vars" {
  count = var.server_count
  content = templatefile("./templates/ansible-agent-var-template.tmpl",
   {
     ansible_port    = "22"
     ansible_user    = module.azure_devops_agents.admin_username
     server_password = module.azure_devops_agents.admin_password
   })

  filename = pathexpand("~/weight-tracker-ansible-docker/inventory/${terraform.workspace}/host_vars/${module.azure_devops_agents.agent_name}.yml")
}

# Create env file only containing postgres info to use with ansible
resource "local_file" "webservers_group_vars" {
  content = templatefile("./templates/ansible-webservers-vars-template.tmpl",
   {
      db_name            = var.db_name
      db_user            = var.postgres_username
      db_pass            = var.postgres_password
      okta_url           = var.okta_url
      okta_client_id     = var.okta_client_id
      okta_secret        = var.okta_secret
      container_reg_usr  = var.container_reg_usr
      container_reg_pass = var.container_reg_pass
      public_ip          = module.network.lb_ip_address
   })

  filename = pathexpand("~/ansible-agent/inventory/webservers_vars/webservers_vars.yml")
  }