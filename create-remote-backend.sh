#!/bin/bash
# create-remote-backend.sh
# This script creates the resource group, storage account, and blob container for the Terraform remote backend.

# Variables - update these as needed
RESOURCE_GROUP="terraform-backend-rg"
LOCATION="eastus"
# The storage account name must be globally unique and in lowercase.
STORAGE_ACCOUNT="mytfstateacct1991"  
CONTAINER_NAME="tfstate"

echo "Logging in to Azure..."
az account show > /dev/null 2>&1 || az login

echo "Creating resource group: $RESOURCE_GROUP in $LOCATION..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --output none

echo "Creating storage account: $STORAGE_ACCOUNT..."
az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --output none

echo "Retrieving storage account key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$RESOURCE_GROUP" \
  --account-name "$STORAGE_ACCOUNT" \
  --query "[0].value" \
  --output tsv)

echo "Creating blob container: $CONTAINER_NAME..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT" \
  --account-key "$ACCOUNT_KEY" \
  --output none

echo "Remote backend resources created successfully:"
echo "Resource Group: $RESOURCE_GROUP"
echo "Storage Account: $STORAGE_ACCOUNT"
echo "Blob Container: $CONTAINER_NAME"
