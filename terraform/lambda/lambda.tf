resource "aws_lambda_function" "lambda_tf_sate" {
  function_name = "lambda_tf_sate"
  filename      = var.lambda_payload_filename

  role             = aws_iam_role.lambda_iam_role.arn
  handler          = var.lambda_function_handler
  source_code_hash = filebase64(var.lambda_payload_filename)
  runtime          = var.lambda_runtime
  memory_size      = 256
  timeout          = 40

  environment {
    variables = {
      STATE_BUCKET_NAME = var.state_bucket_name
      STATE_FILE_NAME = var.state_file_name
      REGION = var.region
    }
  }
}
