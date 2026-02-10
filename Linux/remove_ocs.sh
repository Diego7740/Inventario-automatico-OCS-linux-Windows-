#!/bin/bash

systemctl stop ocsinventory-agent 2>/dev/null
systemctl disable ocsinventory-agent 2>/dev/null

rm -f /usr/bin/ocsinventory-agent
rm -rf /etc/ocsinventory
rm -rf /var/lib/ocsinventory
rm -rf /var/log/ocsinventory

rm -f /etc/systemd/system/ocsinventory-agent.service
systemctl daemon-reload
