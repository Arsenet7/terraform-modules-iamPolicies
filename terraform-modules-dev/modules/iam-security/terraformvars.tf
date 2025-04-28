variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "required_tags" {
  description = "Required tags for resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "webforx"
    Owner       = "terraform"
  }
}

variable "mandatory_tags" {
  description = "List of mandatory tag keys"
  type        = list(string)
  default     = ["Environment", "Project", "Owner"]
}