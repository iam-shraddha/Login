terraform {
  required_providers { aws = { source="hashicorp/aws" } }
}
provider "aws" { region = var.region }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.5.0"
  name    = "${var.cluster_name}-vpc"
  cidr    = "10.0.0.0/16"
  azs     = data.aws_availability_zones.available.names[0:2]
  public_subnets  = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24","10.0.102.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "21.0.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  node_groups = {
    default = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3
      instance_types   = ["t3.medium"]
    }
  }
}

resource "aws_ecr_repository" "app" {
  name = var.ecr_repo
}

data "aws_availability_zones" "available" {}

