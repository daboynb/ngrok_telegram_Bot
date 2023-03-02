# Photo
![Capture](https://user-images.githubusercontent.com/106079917/222291178-04a6feef-17b6-44f2-bb74-4c11d758f50c.PNG)

# Installation 

    - create a Telegram bot and save the chat ID and API; an awesome guide can be found here: https://sarafian.github.io/low-code/2020/03/24/create-private-telegram-chatbot.html

run this in terminal anf fill the required info:

    wget https://raw.githubusercontent.com/daboynb/systemd-ngrok/master/install.sh && chmod +x install.sh && ./install.sh


# Uninstall

To uninstall ngrok systemd :

    sudo systemctl stop ngrok.service
    sudo systemctl disable ngrok.service
    sudo rm /lib/systemd/system/ngrok.service
    sudo rm -rf /opt/ngrok

To uninstall the telegram bot :

    sudo systemctl stop bot.service
    sudo systemctl disable bot.service
    sudo rm /opt/bot/bot.sh
    sudo rm /lib/systemd/system/bot.service
