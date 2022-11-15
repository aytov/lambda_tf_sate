variable "owner" {
  default = "terraform"
}

variable "project" {
  description = "Project name."
  default = "lambda-terraform-state"
}

variable "stage" {
  description = "Stage name (e.g. dev, staging, prod)."
  default = "dev"
}

variable "region" {
  description = "AWS region."
  default = "eu-central-1"
}
