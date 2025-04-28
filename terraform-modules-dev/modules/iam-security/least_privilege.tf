resource "aws_iam_policy" "least_privilege_policy" {
  name        = "webforx-least-privilege-policy"
  description = "Policy that implements least privilege principles"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowEC2DescribeReadOnly",
        Effect = "Allow",
        Action = [
          "ec2:Describe*"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowRDSDescribeReadOnly",
        Effect = "Allow",
        Action = [
          "rds:Describe*"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowS3ReadOnly",
        Effect = "Allow",
        Action = [
          "s3:Get*",
          "s3:List*"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowTagging",
        Effect = "Allow",
        Action = [
          "ec2:CreateTags",
          "rds:AddTagsToResource"
        ],
        Resource = "*",
        Condition = {
          StringLike = {
            "aws:RequestTag/Name" : "${local.allowed_prefix}*"
          }
        }
      },
      {
        Sid    = "AllowSpecificEC2Actions",
        Effect = "Allow",
        Action = [
          "ec2:RunInstances",
          "ec2:CreateVolume"
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" : local.allowed_regions
          },
          StringLike = {
            "aws:RequestTag/Name" : "${local.allowed_prefix}*"
          }
        }
      },
      {
        Sid    = "AllowSpecificRDSActions",
        Effect = "Allow",
        Action = [
          "rds:CreateDBInstance"
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" : local.allowed_regions
          },
          StringLike = {
            "aws:RequestTag/Name" : "${local.allowed_prefix}*"
          }
        }
      }
    ]
  })
}