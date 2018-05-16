#!/bin/bash

curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt install -y nodejs libavahi-compat-libdnssd-dev
mkdir ~/.homebridge && cp config.json ~/.homebridge

sudo npm i -g --unsafe-perm mdns homebridge homebridge-config-ui-x

sudo cp homebridge.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
