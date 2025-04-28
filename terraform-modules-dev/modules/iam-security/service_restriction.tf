resource "aws_iam_policy" "service_restriction_policy" {
  name        = "webforx-service-restriction-policy"
  description = "Policy that restricts EC2 instances to t2/t3 types and RDS to MySQL/PostgreSQL"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # EC2 instance family restrictions
      {
        Sid      = "RestrictEC2InstanceTypes",
        Effect   = "Deny",
        Action   = "ec2:RunInstances",
        Resource = "arn:aws:ec2:*:*:instance/*",
        Condition = {
          "ForAllValues:StringNotLike" = {
            "ec2:InstanceType" : flatten([
              for family in local.allowed_instance_families : ["${family}.*"]
            ])
          }
        }
      },

      # EBS volume type and size restrictions
      {
        Sid      = "RestrictEBSVolumeTypes",
        Effect   = "Deny",
        Action   = "ec2:CreateVolume",
        Resource = "*",
        Condition = {
          StringNotEquals = {
            "ec2:VolumeType" : local.allowed_volume_types
          }
        }
      },
      {
        Sid      = "RestrictEBSVolumeSize",
        Effect   = "Deny",
        Action   = "ec2:CreateVolume",
        Resource = "*",
        Condition = {
          NumericGreaterThan = {
            "ec2:VolumeSize" : local.max_volume_size
          }
        }
      },

      # RDS engine and size restrictions
      {
        Sid      = "RestrictRDSEngines",
        Effect   = "Deny",
        Action   = "rds:CreateDBInstance",
        Resource = "*",
        Condition = {
          StringNotEquals = {
            "rds:DatabaseEngine" : local.allowed_rds_engines
          }
        }
      },
      {
        Sid      = "RestrictRDSSize",
        Effect   = "Deny",
        Action   = "rds:CreateDBInstance",
        Resource = "*",
        Condition = {
          NumericGreaterThan = {
            "rds:AllocatedStorage" : local.max_rds_storage
          }
        }
      },

      # Enforce tagging for all resources
      {
        Sid    = "EnforceTagging",
        Effect = "Deny",
        Action = [
          "ec2:RunInstances",
          "ec2:CreateVolume",
          "rds:CreateDBInstance"
        ],
        Resource = "*",
        Condition = {
          Null = {
            "aws:RequestTag/Environment" : "true",
            "aws:RequestTag/Project" : "true",
            "aws:RequestTag/Owner" : "true"
          }
        }
      }
    ]
  })
}