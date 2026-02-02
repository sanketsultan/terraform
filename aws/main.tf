resource "aws_iam_user" "admin-user" {
    name = "sanket-admin-user"
    tags = {
        description = "Admin user for managing AWS resources"
    }
  
}

resource "aws_iam_policy" "admin-policy" {
    name = "admin-policy"
    path = "/"
    description = "Policy granting full administrative access"

    policy = file("admin-policy.json")
}

resource "aws_iam_policy_attachment" "admin-user-policy-attachment" {
    name       = "admin-user-policy-attachment"
    users      = [aws_iam_user.admin-user.name]
    policy_arn = aws_iam_policy.admin-policy.arn
  
}


resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-sanket-12345"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "example" {
  bucket = aws_s3_bucket.example.id
  key    = "s3-upload.txt"
  content = "This is an example S3 object."

  tags = {
    Name        = "Example object"
    Environment = "Dev"
  }
  
}

resource "aws_iam_group" "admins" {
  name = "Admins"
  
}

data "aws_iam_group" "admins" {
  group_name = "Admins"
  
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "example" {
    bucket = aws_s3_bucket.example.id
    
    depends_on = [aws_s3_bucket_public_access_block.example]
    
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowReadOnly",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::my-tf-test-bucket-sanket-12345",
                "arn:aws:s3:::my-tf-test-bucket-sanket-12345/*"
            ]
        }
    ]
}
EOF
  
}
