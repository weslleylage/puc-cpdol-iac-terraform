resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      Name = "${local.prefix}-ig"
    },
    local.commom_tags
  )
  depends_on = [aws_vpc.this]
}