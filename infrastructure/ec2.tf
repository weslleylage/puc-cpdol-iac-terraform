data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance_type
  count         = 1
  key_name      = aws_key_pair.this.key_name
  user_data     = file("../scripts/userdata-ec2.sh")
  tags = merge(
    {
      Name = "${local.prefix}-ec2"
    },
    local.commom_tags
  )
  vpc_security_group_ids = [aws_security_group.sg-ssh-http.id]
  subnet_id              = aws_subnet.this.id
}