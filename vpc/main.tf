provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "main" {
  cidr_block = "172.23.0.0/16"

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "mysubnet-a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "172.23.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "mysubnet-a"
  }
}
