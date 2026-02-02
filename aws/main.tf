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
