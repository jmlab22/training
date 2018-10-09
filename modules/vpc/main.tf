#provider "aws" {
#  region = "${var.myregion}"
#}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "${var.vpcname}"
  }
}

resource "aws_subnet" "mysubnet" {
  count             = "${length(var.myAZ)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_subnet,count.index)}"
  availability_zone = "${element(var.myAZ,count.index)}"

  tags {
    Name = "mysubnet.${count.index}"
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
    cidr_block = "${var.default_cidr_block}"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "My_route_table"
  }
}

resource "aws_route_table_association" "my_rt_assoc" {
  count = "${length(var.private_subnet)}"

  subnet_id      = "${element(aws_subnet.mysubnet.*.id,count.index)}"
  route_table_id = "${aws_route_table.rt.id}"
}

