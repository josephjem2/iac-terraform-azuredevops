# **Infrastructure as Code with Terraform and Azure DevOps Pipelines**

***

## ✅ **Overview**

This project demonstrates how to automate Azure infrastructure provisioning using **Terraform** integrated with **Azure DevOps CI/CD pipelines**.

**Key Objectives:**

*   Provision Azure resources (Resource Group, App Service Plan, App Service).
*   Automate deployments via Azure DevOps.
*   Apply best practices for state management and security.

***

## ✅ **Architecture Diagram**

![alt text](<Architecture diagram.png>)

***

## ✅ **Prerequisites**

*   Azure subscription.
*   Azure DevOps organization.
*   Terraform installed locally or use Azure Cloud Shell.
*   GitHub account for source code.
*   Basic knowledge of Azure resources.

***

## ✅ **Project Structure**

    iac-terraform-azuredevops/
    │
    ├── terraform/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │
    ├── pipeline/
    │   └── azure-pipelines.yml
    │
    ├── .gitignore
    └── README.md

***

## ✅ **Step-by-Step Guide**

### **Step 1: Setup GitHub Repository**

```bash
git clone https://github.com/<username>/iac-terraform-azuredevops.git
cd iac-terraform-azuredevops
```

***

### **Step 2: Write Terraform Code**

Add files in `terraform/` folder:

**`main.tf`**

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "bootcamp-rg"
    storage_account_name = "bootcampstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = var.app_service_plan_sku["tier"]
    size = var.app_service_plan_sku["size"]
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}
```

**`variables.tf`**

```hcl
variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "bootcamp-rg"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "bootcamp-asp"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "bootcamp-app"
}

variable "app_service_plan_sku" {
  description = "SKU tier and size for App Service Plan"
  type        = map(string)
  default = {
    tier = "Basic"
    size = "B1"
  }
}
```

**`outputs.tf`**

```hcl
output "app_service_url" {
  description = "The default hostname of the Azure App Service"
  value       = azurerm_app_service.app.default_site_hostname
}

output "resource_group_name" {
  description = "The name of the Resource Group created"
  value       = azurerm_resource_group.rg.name
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan created"
  value       = azurerm_app_service_plan.asp.name
}

output "app_service_name" {
  description = "The name of the App Service created"
  value       = azurerm_app_service.app.name
}
```

***

### **Step 3: Initialize and Apply Terraform**

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

***

### **Step 4: Create Azure DevOps Pipeline**

Add `pipeline/azure-pipelines.yml`:

```yaml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: TerraformInstaller@0
  inputs:
    terraformVersion: 'latest'

- script: |
    terraform init
    terraform plan
    terraform apply -auto-approve
  displayName: 'Terraform Apply'

# Optional: Add Key Vault integration for secrets
- task: AzureKeyVault@2
  inputs:
    azureSubscription: '<ServiceConnection>'
    KeyVaultName: '<YourKeyVault>'
    SecretsFilter: '*'
```

***

### **Step 5: Secure Pipeline**

*   Use **Azure Key Vault** for secrets.
*   Implement **approval gates** for production.

***

## ✅ **Best Practices**

*   Use **remote backend** for Terraform state.
*   Secure secrets with **Azure Key Vault**.
*   Implement **approval gates** for production.

***

## ✅ **Resources**

*   <https://developer.hashicorp.com/terraform/docs>
*   <https://learn.microsoft.com/en-us/azure/devops/pipelines>
*   <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs>

***


