# Install

1. For each service there is an install.sh script in the respective directory


## LTE 

1. It's a systemd service that polls 8.8.8.8 to validate network is up

2. Install configures the quectel module to use raw-ip and install a 
   newever version of qmictl

3. There's a file in /usr/local/sbin/ that has the polling loop


## SSH

1. SSH Connection to relay is managed by autossh

2. Config options can be found in /etc/default/autossh


## GPS
