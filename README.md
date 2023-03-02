# What is it?
Script that uses the Telegram Bot API to send your ngrok server address when it boots or when the internet returns after an outage

# Photo
![Capture](https://user-images.githubusercontent.com/106079917/222291178-04a6feef-17b6-44f2-bb74-4c11d758f50c.PNG)

# Installation 

1) create a Telegram bot and save the chat ID and API; an awesome guide can be found here: https://sarafian.github.io/low-code/2020/03/24/create-private-telegram-chatbot.html

2) run this in terminal anf fill the required info :

        wget https://raw.githubusercontent.com/daboynb/ngrok_telegram_Bot/main/install.sh && chmod +x install.sh && ./install.sh


# Uninstall

To uninstall ngrok systemd :

    sudo systemctl stop ngrok.service
    sudo systemctl disable ngrok.service
    sudo rm /lib/systemd/system/ngrok.service
    sudo rm -rf /opt/ngrok

To uninstall the script that uses the Telegram Bot API  :

    sudo systemctl stop bot.service
    sudo systemctl disable bot.service
    sudo rm /lib/systemd/system/bot.service
    sudo rm -rf /opt/bot
    
Systemd ngrok based on https://github.com/vincenthsu/systemd-ngrok
