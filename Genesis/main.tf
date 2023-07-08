terraform {
  # Run init/plan/apply with "backend" commented-out (ueses local backend) to provision Resources (Bucket, Table)
  # Then uncomment "backend" and run init, apply after Resources have been created (uses AWS)
#   backend "s3" {
#     bucket         = "genesis-keval-tf-state-backend-ci-cd"
#     key            = "tf-infra/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "terraform-genesis-tf-state-locking"
#     encrypt        = true
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">=0.13.0"
}

provider "aws" {
  region = "us-east-1"
}


# module "tf-state" {
#   source      = "./modules/tf-state"
#   #Enter bucket name to store tf-state
#   bucket_name = "genesis-keval-tf-state-backend-ci-cd"
# }

# module eks-infra {
#   source = "./modules/eks"
#     # EKS Input Vars
#   subnet_id_1 = module.vpc-infra.public_subnets_1.id
#   subnet_id_2 = module.vpc-infra.public_subnets_2.id
# }

module "vpc-infra" {
  source = "./modules/vpc"
  # VPC Input Varaibles
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ec2" {
  source = "./modules/ec2"

  instance_count            = 2
  instance_type             = "t3.medium"
  volume_count              = 2
  volume_size               = 50
  application_name          = "genesis-app"
  ami_id                    = "ami-06ca3ca175f37dd66"
  subnet_id                 = module.vpc-infra.public_subnets_1
  vpc_security_group_ids    = [module.vpc-infra.ec2_security_group]
}

module "elb" {
  source = "./modules/elb"

  security_groups   = [module.vpc-infra.elb_security_group]
  subnets           = [module.vpc-infra.public_subnets_1, module.vpc-infra.public_subnets_2]
  application_name  = "genesis-app"
  vpc_id            = module.vpc-infra.vpc_id
  target_id         = module.ec2.private_ids
}

module rds{
 source = "./modules/rds"
 subnet_ids             = [module.vpc-infra.public_subnets_1, module.vpc-infra.public_subnets_2]
 vpc_security_group_ids = [module.vpc-infra.rds_security_group]

}

 module "route53" {
    source = "./modules/route53"

    instance_private_ips = module.ec2.private_ips
    load_balancer_dns    = module.elb.dns_name
    vpc_id               = module.vpc-infra.vpc_id
    application_name     = "genesis-app"
 }

