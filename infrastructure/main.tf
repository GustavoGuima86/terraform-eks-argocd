module "vpc" {
  source   = "../modules/aws-vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "eks" {
  source              = "../modules/aws-eks"
  cluster_name        = var.cluster_name
  vpc_id              = module.vpc.vpc_id
  vpc_intra_subnets   = module.vpc.intra_subnets
  vpc_private_subnets = module.vpc.private_subnets
}