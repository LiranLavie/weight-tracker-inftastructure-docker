#Set provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "storage-rg"
    storage_account_name = "tfstat001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  # key delete for safety
    access_key           = ""

  }

  required_version = ">=0.12"
}

provider "azurerm" {
  features {}
}