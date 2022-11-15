resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge({
    Name = "${var.project}-${var.stage}-vpc"
  }, local.tags)
}

resource "aws_subnet" "main" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_mask_bits, count.index * 2 + 1)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge({
    Name = "${var.project}-${var.stage}-subnet-${count.index}"
  }, local.tags)
}