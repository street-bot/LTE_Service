# Turn On:

1. Configure GNNS parameters via AT+QGPSCFG

2. Turn on GNSS via AT+QGPS

3. Can use AT+QGPSLOC to directly get positioning data
	- Lat
	- Long
	- Heigh
	- GNSS Positioning Mode
	- Time
	- Number of Satellites

4. Or Can read usbnmea port to get NMEA sentances

5. Or Can enable nmeasrc with AT+QGPSCFG="nmeasrc",1, and then aquire NMEA sentance via AT+QGPSGNMEA


# Turn Off:

1. AT+QGPSEND


# Error Codes:
501 	Invalid Params
502	Operation Not Supported
503	GNSS Subsystem Busy
504 	Session is ongoing
505	Session not active
506 	Operation Timeout
507	Function not enabled
508	Time information error
512	Validity time is out of range
513	Internal resource error
514	GNSS locked
515	End by E911
516	Not Fixed -> Need to Acquire Satellites
549	Unknown Error
