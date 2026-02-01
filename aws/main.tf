resource "aws_iam_user" "admin-user" {
    name = "sanket"
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