resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-jason-corp2"

  tags = {
    Name        = "My Test bucket"
    Environment = "Dev"
  }
}