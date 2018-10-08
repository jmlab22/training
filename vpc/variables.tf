variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  type        = "string"
  default     = "172.23.0.0/16"
}

variable "region" {
  description = "My preferred region"
  type        = "string"
  default     = "eu-west-1"
}

variable "private_subnet_a" {
  description = "My private subnet in AZ1"
  type        = "string"
  default     = "172.23.1.0/24"
}
