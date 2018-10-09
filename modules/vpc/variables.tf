variable "vpcname" {
  description = "The Name of my VPC"
  type        = "string"
  default     = ""
}

variable "myregion" {
  description = "The Name of my regions"
  type        = "string"
}

variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  type        = "string"
  default     = "172.23.0.0/16"
}

variable "default_cidr_block" {
  description = "ANY CIDR block"
  type        = "string"
  default     = "0.0.0.0/0"
}

variable "region" {
  description = "My preferred region"
  type        = "string"
  default     = "eu-west-1"
}

variable "private_subnet" {
  description = "My private subnet in AZ"
  type        = "list"
  default     = ["172.23.1.0/24", "172.23.2.0/24"]
}

variable "myAZ" {
  description = "My availibility Zone"
  type        = "list"
  default     = ["eu-west-1a", "eu-west-1b"]
}
