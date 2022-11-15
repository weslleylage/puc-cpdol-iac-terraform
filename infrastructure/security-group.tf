resource "aws_security_group" "sg-ssh-http" {
  name        = "${local.prefix}-sg-ssh-http"
  description = "Allow inbound HTTP and SSH traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [aws_vpc.this.ipv6_cidr_block]
    description      = "Rule for HTTP traffic"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [aws_vpc.this.ipv6_cidr_block]
    description      = "Rule for SSH traffic"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.commom_tags
}