resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = merge(
    {
      Name = "${local.prefix}-vpc"
    },
    local.commom_tags
  )
}