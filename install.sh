#!/bin/bash
 
# Ask for sudo privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Check requirements
sudo dpkg -l | grep -qw wget || sudo apt-get install wget -y
sudo dpkg -l | grep -qw unzip || sudo apt-get install unzip -y
sudo dpkg -l | grep -qw curl || sudo apt-get install curl -y
sudo dpkg -l | grep -qw jq || sudo apt-get install jq -y

# determine system arch
ARCH=$(uname -m)
case $ARCH in
    x86_64) ARCH=amd64;;
    aarch64) ARCH=arm64;;
    i386|i686) ARCH=386;;
    *) ARCH=arm;;
esac

# Download and exctract
ARCHIVE=ngrok-v3-stable-linux-$ARCH.zip
DOWNLOAD_URL=https://bin.equinox.io/c/bNyj1mQVY4c/$ARCHIVE

mkdir -p /opt/ngrok
cd /opt/ngrok
sudo wget $DOWNLOAD_URL
unzip $ARCHIVE
sudo rm $ARCHIVE
chmod +x ngrok

# Create the YML file
read -p "Insert yout your_authtoken : " auth_token

create_yml_file() {
    echo "version: \"2\"
authtoken: $auth_token
tunnels:
    ssh:
        proto: tcp
        addr: 22" >  /opt/ngrok/ngrok.yml
}

create_yml_file

# Create the ngrok service file
SERVICE_FILE="/lib/systemd/system/ngrok.service"

# Create the ngrok service file
create_ngrok_service() {
cat << EOF > ${SERVICE_FILE}
[Unit]
Description=ngrok
After=network.target
[Service]
ExecStart=/opt/ngrok/ngrok start --all --config /opt/ngrok/ngrok.yml
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
IgnoreSIGPIPE=true
Restart=always
RestartSec=3
Type=simple
[Install]
WantedBy=multi-user.target
EOF
}

create_ngrok_service

# Enable the service at startup and start it
systemctl enable ngrok.service
systemctl start ngrok.service

######################################################################################

# Create the folder
mkdir -p /opt/bot

SCRIPT_FILE="/opt/bot/bot.sh"

# Ask for bot settings
read -p "Insert your telegram bot api : " bot_api
read -p "Insert the chat id  : " chat_id

# Create a script that sends the address
create_script_file() {
cat << EOF > ${SCRIPT_FILE}
#!/bin/bash

API_TOKEN="${bot_api}"
CHAT_ID="-${chat_id}"

while true; do ping -c1 www.google.com > /dev/null 2>&1 && break; done

public_url=\$(curl -s http://localhost:4040/api/tunnels | jq -r ".tunnels[0].public_url")
if [[ -n "\$public_url" && ! "\$public_url" =~ "bad request" ]]; then
echo "Network is online. Sending address: \$public_url"
curl -s -X POST "https://api.telegram.org/bot\$API_TOKEN/sendMessage" -d "chat_id=\$CHAT_ID" -d "text=\$public_url"
fi

previous_url="\$public_url"

while true; do
    sleep 2
    new_public_url=\$(curl -s http://localhost:4040/api/tunnels | jq -r ".tunnels[0].public_url")
    if [[ -n "\$new_public_url" && ! "\$new_public_url" =~ "bad request" && "\$new_public_url" != "\$previous_url" ]]; then
    echo "New address: \$new_public_url"
    curl -s -X POST "https://api.telegram.org/bot\$API_TOKEN/sendMessage" -d "chat_id=\$CHAT_ID" -d "text=\$new_public_url"
    previous_url="\$new_public_url"
  fi
done
EOF
}

create_script_file

sudo chmod +x /opt/bot/bot.sh

# Create the telegram service file
SERVICE_FILE_TELEGRAM="/lib/systemd/system/bot.service"

create_bot_service() {
cat << EOF > ${SERVICE_FILE_TELEGRAM}
[Unit]
Description=Tgbot
After=network.target

[Service]
ExecStartPre=/bin/sleep 30
ExecStart=/bin/bash /opt/bot/bot.sh

[Install]
WantedBy=multi-user.target
EOF
}

create_bot_service

# Enable the service at startup and start it
systemctl enable bot.service
systemctl start bot.service
