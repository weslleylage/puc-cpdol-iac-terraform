#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl wget nfs-common
sudo mkdir /app
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.this.dns_name}:/ /app
curl -fsSl https://get.docker.com | bash
sudo docker pull weslleylage/puc-app-cpdol-iac
sudo docker run -d -v /usr/share/nginx/html:/app --name puc-app-cpdol-iac -p 8080:80 weslleylage/puc-app-cpdol-iac