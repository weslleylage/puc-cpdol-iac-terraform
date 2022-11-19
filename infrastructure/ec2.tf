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
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = merge(
    {
      Name = "${local.prefix}-ec2"
    },
    local.commom_tags
  )
  vpc_security_group_ids = [aws_security_group.sg-ssh-http.id]
  subnet_id              = aws_subnet.this.id
  depends_on             = [aws_efs_file_system.this, aws_subnet.this, aws_security_group.sg-ssh-http, aws_efs_mount_target.this]
}

resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.this, aws_instance.this]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.path_private_key)
    host        = aws_instance.this[0].public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y curl wget nfs-common git",
      "sudo mkdir /app",
      "curl -fsSl https://get.docker.com | bash",
      "sleep 60",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.this.dns_name}:/ /app",
      "sleep 20",
      "cd /app",
      "sudo rm -rf puc-cpdol-iac-terraform",
      "sudo git clone https://github.com/weslleylage/puc-cpdol-iac-terraform.git",
      "cd puc-cpdol-iac-terraform",
      "sudo docker build -t weslleylage/puc-app-cpdol-iac:latest .",
      "sudo docker run -d -v /app/puc-cpdol-iac-terraform/app:/usr/share/nginx/html -p 8080:80 weslleylage/puc-app-cpdol-iac",
    ]
  }
}