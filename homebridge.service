[Unit]
Description=Node.js HomeKit Server 
After=syslog.target network-online.target

[Service]
Type=simple
User=pi
ExecStart=/usr/bin/homebridge -I
Restart=on-failure
RestartSec=5
KillMode=process

[Install]
WantedBy=multi-user.target
