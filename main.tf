module "vm" {
  source = "./modules/vm"

  environment           = terraform.workspace
  location              = var.location
  vnet_address_space    = var.vnet_address_space
  subnet_address_prefix = var.subnet_address_prefix
  vm_size               = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
}
