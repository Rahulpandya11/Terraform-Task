output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.subnets.private_subnet_id
}

output "web_instance_id" {
  value = module.instances.web_instance_id
}

output "db_instance_id" {
  value = module.instances.db_instance_id
}

output "bastion_instance_id" {
  value = module.bastion.bastion_instance_id
}

output "alb_dns" {
  value = module.alb.alb_dns
}
