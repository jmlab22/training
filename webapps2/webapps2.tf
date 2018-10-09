provider "aws" {
  region = "eu-west-1"
}

module "webapps" {
  source = "../modules/webapps"
  region = "eu-west-1"
  MyVPC  = "prod"
  MyAMI  = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  myAZ   = "eu-west-1a"
}
