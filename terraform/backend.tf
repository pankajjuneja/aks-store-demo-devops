terraform {
  backend "azurerm" {
    storage_account_name = "onlinestoretfstate"
    container_name      = "terraform"
    key                = "terraform.tfstate"
    resource_group_name = "online-store-terraform-state"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
