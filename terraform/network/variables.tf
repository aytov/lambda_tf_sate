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

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR of vpc."
}

variable "availability_zones" {
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  type        = list(string)
  description = "List of availability zones for subnets"
}

variable "subnet_mask_bits" {
  default     = 4
  description = "Subnet mask bits."
}