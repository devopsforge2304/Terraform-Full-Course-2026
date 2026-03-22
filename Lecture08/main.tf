module "network" {

    source = "./modules/network"
    common_tags = var.common_tags
  
}

module "secuity" {
    source = "./modules/security"
    allowed_ports = var.allowed_ports
    vpc_id = module.network.vpc_id
  
}

module "ec2" {
    source = "./modules/ec2"
    environment = var.environment
    instance_type_map = var.instance_type_map
    server_names = var.server_names
    common_tags = var.common_tags
    subnet_id = module.network.subnet_id
    security_group_ids = [module.secuity.security_group_id]
  
}