provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "instances" {
  source          = "./instances"
  subnet_id       = module.subnets.private_subnet_id
  web_sg_id       = module.security_groups.web_sg_id
  db_sg_id        = module.security_groups.db_sg_id
}

module "alb" {
  source          = "./alb"
  subnet_id       = module.subnets.private_subnet_id
  security_group_id = module.security_groups.web_sg_id
  web_instance_id = module.instances.web_instance_id
}

module "bastion" {
  source          = "./bastion"
  subnet_id       = module.subnets.private_subnet_id
  security_group_id = module.security_groups.bastion_sg_id
}
