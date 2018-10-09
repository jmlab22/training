### DATASOURCES ###
### get ubuntu AMI ###

data "aws_ami" "myubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.MyAMI}"]
  }

  owners = ["099720109477"] # Canonical
}

### get UserData ###

data "template_file" "init" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

  vars {
    username = "totouser"
  }
}

### get VPC ID ###
data "aws_vpc" "myvpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.MyVPC}"]
  }
}

### get subnetID ###
data "aws_subnet" "mysubnet" {
  vpc_id = "${data.aws_vpc.myvpc.id}"

  #availability_zone = "eu-west-1a"
  filter {
    name   = "tag:Name"
    values = ["mysubnet.0"]
  }
}

### RESOURCES ###

### Create SG ###
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTPS and SSH"
  vpc_id      = "${data.aws_vpc.myvpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### create EC2 ###
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.myubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet.mysubnet.id}"

  tags {
    Name = "myUbuntu"
  }

  user_data                   = "${data.template_file.init.rendered}"
  key_name                    = "myubuntu"
  associate_public_ip_address = true
  security_groups             = ["${aws_security_group.allow_http.id}"]
}
