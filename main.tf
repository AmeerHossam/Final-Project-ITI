module "network" {
  source = "./modules/network"
  bastion-cidr = var.bastion-cidr
  private-cidr = var.private-cidr
  region = var.region 
  project = var.project
}

