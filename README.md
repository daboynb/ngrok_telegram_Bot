# What is it?
Script that uses the Telegram Bot API to send your ngrok server address when it boots or when the internet returns after an outage

# Photo
![Capture](https://user-images.githubusercontent.com/106079917/222291178-04a6feef-17b6-44f2-bb74-4c11d758f50c.PNG)

# Installation 

1) create a Telegram bot with botfather and save the HTTP API

2) create a group and add the bot to the channel, then make it an admin

3) open botfather, type /setjoingroups and set to disable

3) extract the chat id of the group , type in the search bar of your browser :
        https://api.telegram.org/bot"yourapi"/getUpdates
        
        the result will be something like that

        "my_chat_member":{"chat":{"id":-99999999,"title":"raspberry pi","type":"group" "all_members_are_administrators":true},

        where the id is 99999999

save the chat ID and API following this awesome guide : https://sarafian.github.io/low-code/2020/03/24/create-private-telegram-chatbot.html



4) run this in terminal anf fill the required info :

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