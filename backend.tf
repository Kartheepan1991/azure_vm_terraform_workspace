terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-backend-rg"
    storage_account_name  = "mytfstateacct1991"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"  # Default; override with -backend-config for each workspace.
  }
}
