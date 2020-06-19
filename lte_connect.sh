#!/bin/sh

# To Do -> Point this at our streetbot relay
test_host=8.8.8.8

# Get WWAN0 interface unique name
interface=$(ls /sys/class/net | grep ww)

# Continuously refresh connection
while true; do
    ping -I $interface -c 1 -w 2 $test_host 2&>/dev/null

    if [ $? -eq 0 ]; then
        echo "Connection on $interface up, reconnect not required..."
    else
        echo "Connection down, reconnecting..."
        ip link set $interface down
	qmi-network /dev/cdc-wdm0 stop
	qmi-network /dev/cdc-wdm0 start
	ip link set $interface up
	udhcpc -f -n -q -t 5 -i $interface
    fi

    sleep 30
done
