#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl wget nfs-common
sudo mkdir /app/puc-app-cpdol-iac
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.this.dns_name}:/ /app/puc-app-cpdol-iac
curl -fsSl https://get.docker.com | bash
sudo docker pull weslleylage/puc-app-cpdol-iac
sudo docker run -d -v /usr/share/nginx:/app/puc-app-cpdol-iac --name puc-app-cpdol-iac -p 80:80 weslleylage/puc-app-cpdol-iac