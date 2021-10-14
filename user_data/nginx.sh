#! /bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx