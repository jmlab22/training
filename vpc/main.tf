provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "main" {
  cidr_block = "172.23.0.0/16"

  tags {
    Name = "main"
  }
}
