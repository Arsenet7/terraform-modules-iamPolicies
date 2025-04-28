resource "aws_iam_policy" "region_restriction_policy" {
  name        = "webforx-region-restriction-policy"
  description = "Policy that restricts resource creation to us-east-1 region"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowReadActionsGlobally",
        Effect = "Allow",
        Action = [
          "ec2:Describe*",
          "rds:Describe*",
          "iam:Get*",
          "iam:List*",
          "s3:List*",
          "s3:Get*"
        ],
        Resource = "*"
      },
      {
        Sid    = "DenyNonUsEast1Actions",
        Effect = "Deny",
        NotAction = [
          "ec2:Describe*",
          "rds:Describe*",
          "iam:*",
          "s3:List*",
          "s3:Get*",
          "cloudwatch:*",
          "logs:*",
          "sns:List*",
          "sns:Get*"
        ],
        Resource = "*",
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" : local.allowed_regions
          }
        }
      }
    ]
  })
}