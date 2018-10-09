terraform {
  backend "s3" {
    bucket = "my-bucket-tfstate"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
