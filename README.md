Deployment Steps
1. Navigate to the Project Root

cd /d/azure_terraform_projects/azure_vm_workspace_remotebackend

2. Initialize Terraform
Run initial initialization:

terraform init

3. Create and Deploy the Dev Environment
a. Create/Select the dev Workspace:


terraform workspace new dev || terraform workspace select dev
b. Reinitialize the Backend for Dev:

terraform init -reconfigure \
  -backend-config="resource_group_name=terraform-backend-rg" \
  -backend-config="storage_account_name=mytfstateacct1991" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform-dev.tfstate"

c. Plan and Apply for Dev:

terraform plan -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars -auto-approve

4. Create and Deploy the Stage Environment
a. Create/Select the stage Workspace:


terraform workspace new stage || terraform workspace select stage
b. Reinitialize the Backend for Stage:


terraform init -reconfigure \
  -backend-config="resource_group_name=terraform-backend-rg" \
  -backend-config="storage_account_name=mytfstateacct1991" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform-stage.tfstate"
c. Plan and Apply for Stage:


terraform plan -var-file=envs/stage.tfvars
terraform apply -var-file=envs/stage.tfvars -auto-approve

5. Create and Deploy the Prod Environment
a. Create/Select the prod Workspace:


terraform workspace new prod || terraform workspace select prod
b. Reinitialize the Backend for Prod:


terraform init -reconfigure \
  -backend-config="resource_group_name=terraform-backend-rg" \
  -backend-config="storage_account_name=mytfstateacct1991" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform-prod.tfstate"
c. Plan and Apply for Prod:


terraform plan -var-file=envs/prod.tfvars
terraform apply -var-file=envs/prod.tfvars -auto-approve

6. Verify the Deployment
List the Resources:

terraform state list
View Outputs:

terraform output
Check Remote State (Optional):

az storage blob list --container-name tfstate --account-name mytfstateacct1991 --output table --auth-mode login

7. Cleanup (Optional)
To destroy resources in a workspace (e.g., dev):


terraform workspace select dev
terraform destroy -var-file=envs/dev.tfvars -auto-approve

Notes

Backend Configuration:
Your backend.tf file is minimal. You override the key value during terraform init -reconfigure for each workspace.

Workspaces:
Workspaces allow you to maintain separate state files for different environments (dev, stage, prod) from a single configuration.

Environment Variables:
Use the env-specific tfvars files in the envs/ directory to supply environment-specific variable values.

Remote Backend:
Make sure you have created your remote backend resources (resource group, storage account, blob container) before initializing Terraform with the remote backend.