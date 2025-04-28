output "naming_policy_arn" {
  description = "ARN of the naming convention policy"
  value       = aws_iam_policy.naming_convention_policy.arn
}

output "region_restriction_policy_arn" {
  description = "ARN of the region restriction policy"
  value       = aws_iam_policy.region_restriction_policy.arn
}

output "service_restriction_policy_arn" {
  description = "ARN of the service restriction policy"
  value       = aws_iam_policy.service_restriction_policy.arn
}

output "least_privilege_policy_arn" {
  description = "ARN of the least privilege policy"
  value       = aws_iam_policy.least_privilege_policy.arn
}

output "deny_iam_user_policy_arn" {
  description = "ARN of the deny IAM user policy"
  value       = aws_iam_policy.deny_iam_user_policy.arn
}

output "deny_bare_metal_policy_arn" {
  description = "ARN of the deny bare metal instance policy"
  value       = aws_iam_policy.deny_bare_metal_policy.arn
}

output "prevent_privilege_escalation_policy_arn" {
  description = "ARN of the prevent privilege escalation policy"
  value       = aws_iam_policy.prevent_privilege_escalation.arn
}

output "all_policies" {
  description = "List of all generated IAM policy ARNs"
  value = [
    aws_iam_policy.naming_convention_policy.arn,
    aws_iam_policy.region_restriction_policy.arn,
    aws_iam_policy.service_restriction_policy.arn,
    aws_iam_policy.least_privilege_policy.arn,
    aws_iam_policy.deny_iam_user_policy.arn,
    aws_iam_policy.deny_bare_metal_policy.arn,
    aws_iam_policy.prevent_privilege_escalation.arn
  ]
}