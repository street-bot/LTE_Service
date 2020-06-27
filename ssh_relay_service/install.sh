#!/bin/bash

echo "Installing Autossh"
apt-get install autossh

echo "Configuring SSHD"
sed -i "s/ClientAliveInterval.*/ClientAliveInterval\ 600/g"
sed -i "s/ClientAliveCountMax.*/ClientAliveCountMax\ 0/g"

echo "Make sure ClientAliveInerval 60 is set on the relay !"
echo "Make sure ClientAliveCountMax 6 is set on the relay !"

echo "Configuring Service"
cp autossh /etc/default/
cp streetbot_ssh.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable streetbot_ssh.service
systemctl start streetbot_ssh.service
