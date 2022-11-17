resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = merge(
    {
      Name = "${local.prefix}-vpc"
    },
    local.commom_tags
  )
}