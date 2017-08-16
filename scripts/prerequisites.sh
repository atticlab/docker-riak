#!/bin/bash

# Install docker
apt update
apt -y install git curl make apt-transport-https ca-certificates gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt install -y docker-ce
service docker start

# Install docker-compose 
curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Giving non-root access (optional)
LOGIN=""
while true
do
    read -ra LOGIN -p "Username to add to docker user group: "
    LOGIN=${LOGIN,,}
    if [[ $LOGIN == '' ]]; then
        echo "Error: username cannot be empty!"
    else
        break
    fi
done

groupadd docker
gpasswd -a ${LOGIN} docker
service docker restart