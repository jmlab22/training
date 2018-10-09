output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${aws_vpc.main.cidr_block}"
}

output "private_subnet" {
  description = "Private subnet"
  value       = "${aws_subnet.mysubnet.*.cidr_block}"
}

output "Internet-Gateway" {
  description = "My Internet Gateway"
  value       = "${aws_internet_gateway.gw.id}"
}

output "route_table" {
  description = "My Route Table"
  value       = "${aws_route_table.rt.id}"
}

output "my-bucket-tfstate" {
  description = "My Bucket TFSTATE"
  value       = "${aws_s3_bucket.my-bucket-tfstate.arn}"
}
