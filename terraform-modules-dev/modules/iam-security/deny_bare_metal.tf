resource "aws_iam_policy" "deny_bare_metal_policy" {
  name        = "webforx-deny-bare-metal-policy"
  description = "Policy that denies EC2 bare metal instance types"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "DenyBareMetalInstances",
        Effect   = "Deny",
        Action   = "ec2:RunInstances",
        Resource = "arn:aws:ec2:*:*:instance/*",
        Condition = {
          StringLike = {
            "ec2:InstanceType" : "*.metal"
          }
        }
      }
    ]
  })
}