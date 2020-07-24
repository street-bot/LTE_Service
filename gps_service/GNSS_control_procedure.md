# Quectel EC25 GNSS Module

## Overview
The Quectel EC25 modem contains a GNSS module capable of GPS, Glonass, Galileo, and BeiDou position fixes.
On connection to a USB host, the Quectel EC25 registers itself as a series of USB devices:
| Device | Purpose |
| ------ | ------- |
| ttyUSB0 | Data modem |
| ttyUSB1 | GPS NMEA message publisher |
| ttyUSB2 | AT Command TTY |
| ttyUSB3 | PPP data pipe |
For more information on EC25 USB operations, please check out this [datasheet](https://www.quectel.com/UploadImage/Downlad/Quectel_WCDMA&LTE_Linux_USB_Driver_User_Guide_V1.8.pdf).

The GPS mode is always enabled; other positioning providers can be optionally enabled/disabled.

The GNSS module user manual can be found [here](https://usermanual.wiki/Document/QuectelEC2526EC21GNSSATCommandsManualV11.894777683).


## Startup Procedure
### Establishing connection
Connect to the AT command TTY with 115200 8N1 and no hardware flow control.
*You can test connectivity by typing `ATI` and press Enter to fetch the EC25 device info*

### Turn On GNSS Module:
1. Configure GNNS parameters via AT+QGPSCFG.
	```
	AT+QGPSCFG="gpsnmeatype",3
	```

2. Turn on GNSS.
	```
	AT+QGPS=1
	```

3. Can use `AT+QGPSLOC` to directly get positioning data
	- Lat
	- Long
	- Height
	- GNSS Positioning Mode
	- Time
	- Number of Satellites

4. Or Can read usbnmea port (ttyUSB1) to get NMEA sentances

5. Or Can enable nmeasrc with `AT+QGPSCFG="nmeasrc",1`, and then aquire NMEA sentance via `AT+QGPSGNMEA`


### Turn Off:
```
AT+QGPSEND
```

## Piping Data into ROS Pub/Sub
The general idea is:
1. Parse the streaming NMEA messages from ttyUSB1
2. Populate the appropriate fields in a ROS message
3. Publish the message into ROS pub/sub

Thankfully this is a solved problem thanks to the ROS community.
We can use the [`nmea_navsat_driver`](https://wiki.ros.org/nmea_navsat_driver) with data piped in from a serial port to publish the location data.
```bash
# Example publishing node
rosrun nmea_navsat_driver nmea_serial_driver _port:=/dev/ttyUSB1 _baud:=115200
```

## Error Codes:
| Number | Meaning |
| ------ | ------- |
|501 |	Invalid Params |
|502	| Operation Not Supported |
|503	| GNSS Subsystem Busy |
|504 |	Session is ongoing |
|505	| Session not active |
|506 | Operation Timeout |
|507	| Function not enabled |
|508	| Time information error |
|512	| Validity time is out of range |
|513	| Internal resource error |
|514	| GNSS locked |
|515	| End by E911 |
|516	| Not Fixed -> Need to Acquire Satellites |
|549	| Unknown Error |
