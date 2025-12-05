
# Location for Azure resources
variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "East US"
}

# Resource Group name
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "bootcamp-rg"
}

# App Service Plan name
variable "app_service_plan_name" {
  description = "Name of the Azure App Service Plan"
  type        = string
  default     = "bootcamp-asp"
}

# App Service name
variable "app_service_name" {
  description = "Name of the Azure App Service"
  type        = string
  default     = "bootcamp-app"
}

# SKU for App Service Plan
variable "app_service_plan_sku" {
  description = "SKU tier and size for the App Service Plan"
  type        = map(string)
  default = {
    tier = "Basic"
    size = "B1"
  }
}
