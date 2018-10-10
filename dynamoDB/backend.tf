terraform {
  backend "s3" {
    bucket = "my-bucket-tfstate"
    key    = "dynamodb/terraform.tfstate"
    region = "eu-west-1"
  }
}
