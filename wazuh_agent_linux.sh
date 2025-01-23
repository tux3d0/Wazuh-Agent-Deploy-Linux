#!/bin/bash
#
# This script is used for installing the wazuh agent to debian based systems.

echo "Downloading the Wazuh repository key"
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH |sudo gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && sudo chmod 644 /usr/share/keyrings/wazuh.gpg
echo " Adding the Wazuh repository"
sudo echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee -a /etc/apt/sources.list.d/wazuh.list
echo "Updating the package lists"
sudo apt-get update
echo "Installing the Wazuh agent"
WAZUH_MANAGER="192.168.1.110" sudo apt-get install wazuh-agent -y
echo "Starting the Wazuh agent"
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
echo "Installation finished, remember to approve the agent in the manager"