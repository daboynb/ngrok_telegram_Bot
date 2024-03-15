If you wanna help me

<a href="https://www.buymeacoffee.com/daboynb" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

# What is it?
 This script does two things:

1) Installs ngrok and starts it automatically at boot using systemd.

2) Creates a bash script that sends you the updated address of your Raspberry Pi on Ngrok via Telegram every time the Raspberry Pi starts up or after an internet interruption.

# Photo
![Capture](https://user-images.githubusercontent.com/106079917/222291178-04a6feef-17b6-44f2-bb74-4c11d758f50c.PNG)

# Installation 

1) Create an Ngrok account at https://dashboard.ngrok.com/ and save the auth token.

2) Create a Telegram bot with BotFather and save the HTTP API.

3) Create a group, add the bot to the channel, and make it an admin.

4) Open BotFather, type /setjoingroups, and set it to disable.

5) To get the chat ID of the group, type the following in the search bar of your browser:

        https://api.telegram.org/botyourapi/getUpdates
        
   The result will be something like this:

        "my_chat_member":{"chat":{"id":-99999999,"title":"raspberry pi","type":"group" "all_members_are_administrators":true}

   look at the output, the group name is "raspberry pi" and the chat ID is "99999999".

6) Now that you have all the required info, run this in the terminal and fill in the required fields:

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
