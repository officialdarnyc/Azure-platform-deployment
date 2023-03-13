terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.47.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "ic"
    storage_account_name = "tfbackend01"
    container_name       = "tf-state-container"
    key                  = "dotnetapp/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}