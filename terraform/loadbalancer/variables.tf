variable "project" {
  description = "Project name."
}

variable "stage" {
  description = "Stage name (e.g. dev, staging, prod)."
}

variable "region" {
  description = "AWS region."
}

variable "tags" {
  type        = map(any)
  description = "Additional tags."
}

variable "vpc_id" {
  description = "ID of vpc."
}

variable "subnet_ids" {
  type        = list(any)
  description = "List of subnet ids."
}

variable "additional_security_group_ids" {
  default     = []
  type        = list(any)
  description = "List of additional security groups ids."
}

variable "enable_access_logs" {
  default     = false
  description = "Enable access logs to s3."
}

variable "access_logs_bucket" {
  default     = ""
  description = "S3 bucket to store the access logs, only needed if enabled."
}