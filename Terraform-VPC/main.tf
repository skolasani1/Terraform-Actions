module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
}

module "EC2" {
    source = "./modules/EC2"
    sg_id = module.sg.sg_id
    subnets = module.vpc.subnet_ids
}

module "alb" {
    source = "./modules/alb"
    sg_id = module.sg.sg_id
    subnets = module.vpc.subnet_ids
    vpc_id = module.vpc.vpc_id
    instance = module.EC2.instance
}
