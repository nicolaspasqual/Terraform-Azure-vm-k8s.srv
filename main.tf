terraform {

  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraformstatenicolas"
    container_name       = "terraformstate"
    key                  = "azure-vnet-k8s/terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}