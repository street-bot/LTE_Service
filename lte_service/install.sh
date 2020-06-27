#!/bin/bash

echo "Installing Dependancies"
apt-get install -y glib-networking libmbim-glib-dev libgudev-1.0-dev autoconf

echo "Install libqmi-dev"
tar -xzvf 1.22.6.tar.gz
cd libqmi-1.22.6
./autogen.sh
./configure --prefix=/usr 
make
make install
cd ..
#
echo "Configure QMI Device to use raw-ip"
interface=$(ip a | grep ww | awk '{print $2}' | sed 's/\://g')
ip link set $interface down
echo Y > /sys/class/net/$interface/qmi/raw_ip
ip link set $interface up

echo "Install the lte_connect systemd service"
cat << EOF > /etc/udev/rules.d/90-wwan.rules
SUBSYSTEM=="net", KERNEL=="wwan*, TAG+="systemd", ENV{SYSTEMD_WANTS}+="lte_connect.service"
EOF
cp lte_connect.service /etc/systemd/system/lte_connect.service
cp lte_connect.sh /usr/local/sbin/lte_connect.sh
systemctl daemon-reload
systemctl enable lte_connect.service

echo "Device drivers and software installed and configured"
echo "To connect to LTE Network:"
echo "reboot"
echo "systemctl start lte_connect.server"

