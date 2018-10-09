resource "aws_s3_bucket" "my-bucket-tfstate" {
  bucket = "my-bucket-tfstate"
  acl    = "private"

  tags {
    Name        = "My bucket tfsate"
    Environment = "Training"
  }
}
