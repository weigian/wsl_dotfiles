#!/bin/env sh

echo -- Docker Install Started

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start

sudo groupadd docker
sudo usermod -aG docker ${USER}

echo -- You must logout/login to let docker group take effective
echo -- Docker Install Completed
echo -- test with "$docker run hello-world"
