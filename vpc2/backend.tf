terraform {
  backend "s3" {
    bucket         = "my-bucket-tfstate"
    key            = "vpc2/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "MyLockDB"
  }
}
