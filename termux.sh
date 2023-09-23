#!/bin/bash

apt update -y
apt install wget -y
apt install openssh -y
apt install sshpass -y
wget -O ~/../usr/bin/menu https://raw.githubusercontent.com/chalyyzhu/ngrokOpenWrt/main/ng.sh
chmod +x ~/../usr/bin/menu
echo "" > ~/user.txt

echo "[ + ] instalasi selesai.. ketik menu bree... "
rm termux.sh
