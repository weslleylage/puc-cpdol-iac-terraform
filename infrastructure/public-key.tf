resource "aws_key_pair" "this" {
  key_name   = "aws_key"
  public_key = var.aws_public_key
}