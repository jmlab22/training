output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${aws_vpc.main.cidr_block}"
}

output "private_subnet_a" {
  description = "Private subnet A"
  value       = "${aws_subnet.mysubnet-a.cidr_block}"
}

output "Internet-Gateway" {
  description = "My Internet Gateway"
  value       = "${aws_internet_gateway.gw.id}"
}
