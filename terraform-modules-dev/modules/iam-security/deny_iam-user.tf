resource "aws_iam_policy" "deny_iam_user_policy" {
  name        = "webforx-deny-iam-user-policy"
  description = "Policy that denies IAM user creation and deletion"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "DenyIAMUserCreationDeletion",
        Effect = "Deny",
        Action = [
          "iam:CreateUser",
          "iam:DeleteUser",
          "iam:CreateGroup",
          "iam:DeleteGroup"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowIAMManagement",
        Effect = "Allow",
        Action = [
          "iam:Get*",
          "iam:List*",
          "iam:CreatePolicy",
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:AttachGroupPolicy",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}