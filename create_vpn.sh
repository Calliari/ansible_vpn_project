#!/bin/bash

# 4)user-data
sudo apt-get update -y
sudo apt-get dist-upgrade -y
# sudo reboot || sudo shutdown -r +1


# https://git.io/vpnsetup
git clone https://github.com/hwdsl2/setup-ipsec-vpn

#run the vpn script
sudo /home/ubuntu/setup-ipsec-vpn/vpnsetup.sh > /home/ubuntu/vpnsetup.txt

# piping the output into "/home/ubuntu/vpnsetup.txt"
cp /home/ubuntu/setup-ipsec-vpn/vpnsetup.sh /home/ubuntu/vpnsetup.sh

# Get the varibles from "/home/ubuntu/vpnsetup.txt" OLD
# IPSEC_PSK=$(grep -oP '(?<="IPsec PSK: ).*' /home/ubuntu/vpnsetup.txt | cut -d',' -f1); IPSEC_PSK=$(echo "${IPSEC_PSK::-1}"); USERNAME=$(grep -oP '(?<="Username: ).*' /home/ubuntu/vpnsetup.txt | cut -d',' -f1); USERNAME=$(echo "${USERNAME::-1}"); PASSWORD=$(grep -oP '(?<="Password: ).*' /home/ubuntu/vpnsetup.txt | cut -d',' -f1); PASSWORD=$(echo "${PASSWORD::-1}");

# Get the varibles from "/home/ubuntu/vpnsetup.txt" NEW
IPSEC_PSK=$(grep -oP 'IPsec PSK: .*' /home/ubuntu/vpnsetup.txt | awk  '{print $3}');
USERNAME=$(grep -oP 'Username: .*' /home/ubuntu/vpnsetup.txt | awk  '{print $2}');
PASSWORD=$(grep -oP 'Password: .*' /home/ubuntu/vpnsetup.txt | awk  '{print $2}');
PSK=$(cat vpnsetup.sh | grep YOUR_IPSEC_PSK=''); sudo sed -i "s/$PSK/YOUR_IPSEC_PSK=\'$IPSEC_PSK\'/" /home/ubuntu/vpnsetup.sh; USER=$(cat vpnsetup.sh | grep YOUR_USERNAME=''); sudo sed -i "s/$USER/YOUR_USERNAME=\'$USERNAME\'/" /home/ubuntu/vpnsetup.sh;  PASS=$(cat vpnsetup.sh | grep YOUR_PASSWORD=''); sudo sed -i "s/$PASS/YOUR_PASSWORD=\'$PASSWORD\'/" /home/ubuntu/vpnsetup.sh;


# Run the vpn with credentials in place "/home/ubuntu/vpnsetup.txt"
IPSEC_PSK=$(grep -oP '(?<=IPsec PSK: ).*' /home/ubuntu/vpnsetup.txt);
USERNAME=$(grep -oP '(?<=Username: ).*' /home/ubuntu/vpnsetup.txt);
PASSWORD=$(grep -oP '(?<=Password: ).*' /home/ubuntu/vpnsetup.txt);


#
sudo sed -i s/YOUR_IPSEC_PSK=\'\'/YOUR_IPSEC_PSK=\'$IPSEC_PSK\'/ /home/ubuntu/vpnsetup.sh
sudo sed -i s/YOUR_USERNAME=\'\'/YOUR_USERNAME=\'$USERNAME\'/ /home/ubuntu/vpnsetup.sh
sudo sed -i s/YOUR_PASSWORD=\'\'/YOUR_PASSWORD=\'$PASSWORD\'/ /home/ubuntu/vpnsetup.sh


sudo /home/ubuntu/vpnsetup.sh && sudo systemctl restart ipsec.service


# Important notes:   https://git.io/vpnnotes
# Setup VPN clients: https://git.io/vpnclients
