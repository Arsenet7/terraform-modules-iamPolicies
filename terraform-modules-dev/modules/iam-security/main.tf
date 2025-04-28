provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "All"
      Terraform   = "true"
      Module      = "iam_security"
    }
  }
}

# Define the expected naming prefix for all resources
locals {
  allowed_prefix            = "webforx-"
  allowed_regions           = ["us-east-1"]
  allowed_instance_families = ["t2", "t3"]
  allowed_volume_types      = ["gp3"]
  max_volume_size           = 30
  allowed_rds_engines       = ["mysql", "postgres"]
  max_rds_storage           = 30
}