provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "mysubnet-a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_subnet_a}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "mysubnet-a"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "MyInternetGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "My_route_table"
  }
}

resource "aws_route_table_association" "my_rt_assoc" {
  subnet_id      = "${aws_subnet.mysubnet-a.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_s3_bucket" "my-bucket-tfstate" {
  bucket = "my-bucket-tfstate"
  acl    = "private"

  tags {
    Name        = "My bucket tfsate"
    Environment = "Training"
  }
}
