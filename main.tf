
# Configure Terraform backend to store state in Azure Storage
terraform {
  backend "azurerm" {
    resource_group_name  = "bootcamp-rg"          # Resource Group for storage account
    storage_account_name = "bootcampstorage"      # Storage account name
    container_name       = "tfstate"              # Blob container for state file
    key                  = "terraform.tfstate"    # Name of the state file
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan
resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = var.app_service_plan_sku["tier"]
    size = var.app_service_plan_sku["size"]
  }
}

# App Service
resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}
