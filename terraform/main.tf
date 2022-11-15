locals {
  tags = {
    CreatedBy = "Terraform"
    Owner     = var.owner
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "aytovcom-tfstate" //Replace
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}

module "network" {
  source  = "./network"
  project = var.project
  stage   = var.stage
  region  = var.region
  tags    = local.tags
}

module "loadbalancer" {
  source = "./loadbalancer"

  vpc_id                        = module.network.vpc_id
  additional_security_group_ids = []
  subnet_ids                    = module.network.subnet_ids

  project = var.project
  stage   = var.stage
  region  = var.region
  tags    = local.tags
}

module "lambda" {
  source = "./lambda"

  project = var.project
  stage   = var.stage
  region  = var.region
  state_bucket_name = "aytovcom-tfstate" //Replace
  state_file_name = "terraform.tfstate"
  tags    = local.tags
}
