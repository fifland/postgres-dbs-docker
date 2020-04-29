 #!/bin/sh

if [ $(/usr/bin/id -u) -ne 0 ]; then
    echo "Not running as root! Use sudo please"
    exit
fi
 
pacman -Syu --noconfirm
pacman -S  --needed --noconfirm docker docker-compose
 
systemctl start docker
systemctl enable docker
