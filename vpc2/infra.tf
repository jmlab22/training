provider "aws" {
  region = "eu-west-1"
}

module "VPC" {
  source             = "../modules/vpc"
  myregion           = "eu-west-1"
  vpcname            = "prod"
  vpc_cidr_block     = "10.1.0.0/16"
  region             = "eu-west-1"
  private_subnet     = ["10.1.1.0/24", "10.1.2.0/24"]
  default_cidr_block = "0.0.0.0/0"
  myAZ               = ["eu-west-1a", "eu-west-1b"]
}
