resource "aws_efs_file_system" "this" {
  encrypted = true
  tags = merge(
    {
      Name = "${local.prefix}-efs"
    },
    local.commom_tags
  )
}