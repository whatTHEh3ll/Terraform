#!/bin/bash

# Installing kubectl on an Ubuntu machine
sudo apt-get update && sudo apt-get install -y apt-transport-https
# Installing Docker on an Ubuntu machine
sudo apt install -y docker.io
sudo usermod -aG docker $USER
#Install cloud torrent with docker
docker run --name ct -d -p 63000:63000 --restart always -v /root/downloads:/downloads jpillora/cloud-torrent --port 63000