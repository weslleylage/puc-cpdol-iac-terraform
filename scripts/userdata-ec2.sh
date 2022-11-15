#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl wget
curl -fsSl https://get.docker.com | bash
sudo docker pull nginx
sudo docker run -s --name nginx -p 8080:80 nginx

#atachar o efs no ec2
#montar o volume do docker pro path do efs