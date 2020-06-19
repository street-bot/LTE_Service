#!/bin/bash
cp streetbot_ssh.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable streetbot_ssh.service
systemctl start streetbot_ssh.service
