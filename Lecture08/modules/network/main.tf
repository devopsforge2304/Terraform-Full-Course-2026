locals {
  # cidrsubnet function
  subnet1 = cidrsubnet(var.subnet_cidr, 8, 1)

  instance_tag = {
    for key, value in var.common_tags :
    upper(key) => upper(value)
  }

}

#VPC
resource "aws_vpc" "main" {
  cidr_block = var.subnet_cidr

  tags = merge(
    local.instance_tag,
    {
      Name        = "main-vpc"
      Environment = "dev"
    }
  )

}

#subnet

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id

  cidr_block = local.subnet1

  tags = merge(
    local.instance_tag,
    {
      Name = "public-subnet"
    }
  )

}
