variable "project" {
  description = "Project name."
}

variable "stage" {
  description = "Stage name (e.g. dev, staging, prod)."
}

variable "tags" {
  type        = map(any)
  description = "Additional tags."
}

variable "region" {
  description = "AWS region."
}

variable "lambda_payload_filename" {
  default = "../lambda/target/cf-lambda-0.1.0-SNAPSHOT.jar"
}

variable "lambda_function_handler" {
  default = "com.aytov.lambda.LambdaTerraformStateHandler"
}

variable "lambda_runtime" {
  default = "java11"
}

variable "state_bucket_name" {
  description = "Name of the terraform S3 bucket."
}

variable "state_file_name" {
  description = "Name of the terraform state file."
}
