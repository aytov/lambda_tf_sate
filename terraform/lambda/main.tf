locals {
  version = "0.0.1"
  module  = "lambda"

  tags = merge({
    version = local.version
    project = var.project
    stage   = var.stage
    module  = local.module
  }, var.tags)
}
