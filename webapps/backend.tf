terraform {
  backend "s3" {
    bucket = "my-bucket-tfstate"
    key    = "webapps/terraform.tfstate"
    region = "eu-west-1"
  }
}
