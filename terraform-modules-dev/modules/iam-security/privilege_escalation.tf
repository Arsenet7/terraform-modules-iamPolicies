resource "aws_iam_policy" "prevent_privilege_escalation" {
  name        = "webforx-prevent-privilege-escalation"
  description = "Policy that prevents privilege escalation"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "DenyPermissionModifications",
        Effect = "Deny",
        Action = [
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:SetDefaultPolicyVersion",
          "iam:CreateAccessKey",
          "iam:UpdateAccessKey",
          "iam:PutUserPolicy",
          "iam:PutGroupPolicy",
          "iam:AddUserToGroup",
          "iam:UpdateAssumeRolePolicy"
        ],
        Resource = "*"
      },
      {
        Sid    = "DenyPolicyAttachments",
        Effect = "Deny",
        Action = [
          "iam:AttachUserPolicy",
          "iam:DetachUserPolicy"
        ],
        Resource = "*"
      }
    ]
  })
}