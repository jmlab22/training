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
data "aws_subnet_ids" "mysubnet" {
  vpc_id = "${data.aws_vpc.myvpc.id}"
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
  count = "${length(data.aws_subnet_ids.mysubnet.ids)}"
  #count = 2
  ami           = "${data.aws_ami.myubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(data.aws_subnet_ids.mysubnet.ids,count.index)}"
  
  tags {
    Name = "myUbuntu-${count.index}" 
  }

  user_data                   = "${data.template_file.init.rendered}"
  key_name                    = "myubuntu"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.allow_http.id}"]
}

### Create a new load balancer  ###

resource "aws_elb" "jml-elb" {
  name               = "jml-terraform-elb"
  #availability_zones = "${var.myAZ}"
  subnets = ["${data.aws_subnet_ids.mysubnet.ids}"]
  security_groups = ["${aws_security_group.allow_http.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  instances                   = ["${aws_instance.web.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "jml-terraform-elb"
  }
   
}
