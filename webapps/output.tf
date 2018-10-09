output "myinstanceid" {
  description = "My Instance ID"
  value       = "${aws_instance.web.id}"
}

output "mypublicip" {
  description = "My Instance Public IP"
  value       = "${aws_instance.web.public_ip}"
}

output "mypublicdns" {
  description = "My Instance Public DNS"
  value       = "${aws_instance.web.public_dns}"
}
