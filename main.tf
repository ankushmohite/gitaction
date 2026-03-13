resource "aws_s3_bucket" "new_bucket" {
  bucket = "shubhamdhole972026"

  tags = {
    Name        = "CreatedByTerraform"
    Environment = "Dev"
    Owner       = "Shubham"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.new_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
