provider "aws" {
  region = "us-east-1"
}

module "iam_security" {
  source = "./modules/iam-security"

  # Pass variables to the module
  account_id  = "238564712748" # Replace with your actual AWS account ID
  environment = "dev"
}

# Output the policies created by the module
output "iam_policies" {
  description = "List of all IAM policies created"
  value       = module.iam_security.all_policies
}