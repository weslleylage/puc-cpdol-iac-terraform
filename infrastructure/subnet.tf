data "aws_availability_zones" "this" {
  state = "available"
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.this.names[0]
  tags = merge(
    {
      Name = "${local.prefix}-subnet"
    },
    local.commom_tags
  )
}