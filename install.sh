#!/bin/bash

DIR="/root/.config/ngrok"
FILE=$DIR/ngrok.yml

if [ ! -d "$DIR" ]; then
   mkdir $DIR
elif [ -f "$FILE" ]; then
   rm $FILE
fi

read -rp "INPUT YOUR ACESS TOKEN : " token

echo "authtoken: $token" > $FILE
cat >> $FILE << EOF
version: "2"
tunnels:
  WEB LUCI:
    addr: localhost:80
    proto: http
  SSH:
    addr: localhost:22
    proto: tcp
  YACD:
    addr: localhost:9090
    proto: http
EOF

echo "INSTALL [ NGROK MODULES ]"
wget -O /usr/bin/ngrok https://github.com/chalyyzhu/ngrokOpenWrt/raw/main/ngrok && chmod +x /usr/bin/ngrok

echo "INSTALL [ NGROK AUTO START RUN ]"
wget -O /etc/init.d/start-ngrok https://raw.githubusercontent.com/chalyyzhu/ngrokOpenWrt/main/start-ngrok && chmod +x /etc/init.d/start-ngrok 

