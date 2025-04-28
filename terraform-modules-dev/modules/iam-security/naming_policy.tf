resource "aws_iam_policy" "naming_convention_policy" {
  name        = "webforx-naming-convention-policy"
  description = "Policy that enforces the webforx-* naming convention for resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "EnforceNamingConvention",
        Effect = "Deny",
        Action = [
          "ec2:RunInstances",
          "ec2:CreateVolume",
          "rds:CreateDBInstance",
          "s3:CreateBucket",
          "dynamodb:CreateTable",
          "lambda:CreateFunction",
          "iam:CreateRole"
        ],
        Resource = "*",
        Condition = {
          StringNotLike = {
            "aws:RequestTag/Name" : "${local.allowed_prefix}*"
          }
        }
      }
    ]
  })
}