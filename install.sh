#!/bin/bash

curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt install -y nodejs libavahi-compat-libdnssd-dev
[ ! -d ~/.homebridge ] && mkdir ~/.homebridge && cp config.json ~/.homebridge

sudo npm i -g --unsafe-perm homebridge homebridge-config-ui-x

sudo bash -c "cat > /etc/systemd/system/homebridge.service" << EOL
[Unit]
Description=Homebridge Config UI X
After=syslog.target network-online.target

[Service]
Type=simple
User=$USER
ExecStart=$(which homebridge-config-ui-x) -U /$USER/.homebridge -I
Restart=on-failure
RestartSec=3
KillMode=process
CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_CHOWN CAP_FOWNER CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_SYS_ADMIN
AmbientCapabilities=CAP_NET_RAW

[Install]
WantedBy=multi-user.target
EOL

sudo bash -c "cat > /etc/systemd/system/homebridge-config-ui-x.service" << EOL
[Unit]
Description=Node.js HomeKit Server 
After=syslog.target network-online.target

[Service]
Type=simple
User=$USER
ExecStart=$(which homebridge) -U /$USER/.homebridge -I 
Restart=on-failure
RestartSec=3
KillMode=process

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
sudo systemctl enable homebridge-config-ui-x
sudo systemctl start homebridge-config-ui-x
