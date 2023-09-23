#!/bin/bash

DIR="/root/.config/ngrok"
FILE=$DIR/ngrok.yml

if [ ! -d "/root/.config" ]; then
   mkdir /root/.config
fi

if [ ! -d "$DIR" ]; then
   mkdir $DIR
elif [ -f "$FILE" ]; then
   rm $FILE
fi

opkg update && opkg install openssh-sftp-server
read -rp "INPUT YOUR ACESS TOKEN : " token

echo "authtoken: $token" > $FILE
cat >> $FILE << EOF
region: ap
version: "2"
tunnels:
  WEB LUCI:
    addr: 80
    proto: tcp
  SSH:
    addr: 22
    proto: tcp
  YACD:
    addr: 9090
    proto: tcp
EOF

echo "INSTALL [ NGROK MODULES ]"
wget -O /usr/bin/ngrok https://github.com/chalyyzhu/ngrokOpenWrt/raw/main/ngrok && chmod +x /usr/bin/ngrok

echo "INSTALL [ NGROK AUTO START RUN ]"
wget -O /etc/init.d/start-ngrok https://raw.githubusercontent.com/chalyyzhu/ngrokOpenWrt/main/start-ngrok && chmod +x /etc/init.d/start-ngrok 

