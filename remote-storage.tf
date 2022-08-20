# Create resource group
resource "azurerm_resource_group" "storage-rg" {
  name     = var.storage_rg_name
  location = var.resource_group_location
}

#Create a storage account to store state
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.storage-rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.account_replication_type
}

#Add a storage container for storing state
resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.storage_container_access_type
}
