
# Output the App Service URL
output "app_service_url" {
  description = "The default hostname of the Azure App Service"
  value       = azurerm_app_service.app.default_site_hostname
}

# Output the Resource Group name
output "resource_group_name" {
  description = "The name of the Resource Group created"
  value       = azurerm_resource_group.rg.name
}

# Output the App Service Plan name
output "app_service_plan_name" {
  description = "The name of the App Service Plan created"
  value       = azurerm_app_service_plan.asp.name
}

# Output the App Service name
output "app_service_name" {
  description = "The name of the App Service created"
  value       = azurerm_app_service.app.name
}
