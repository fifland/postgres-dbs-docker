#!/bin/sh

 if [ $(/usr/bin/id -u) -ne 0 ]; then
     echo "Not running as root! Use sudo please"
     exit
 fi

apt-get update -qq

#get docker requirements for Debian
apt-get install -yqq \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
  $(lsb_release -cs) \
  stable"

apt-get update -qq && apt-get install -yqq docker-ce

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl start docker
systemctl enable docker
