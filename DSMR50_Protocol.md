# Protocol

An extract from: https://www.netbeheernederland.nl/_upload/Files/Slimme_meter_15_32ffe3cc38.pdf

## Header (?)
Version information for P1 output                                   1-3:0.2.8.255
Date-time stamp of the P1 message                                   0-0:1.0.0.255
  YYMMDDhhmmssX

## Electricity data
Equipment identifier                                                0-0:96.1.1.255
Meter Reading electricity delivered to client                       1-0:1.8.1.255
 (low tariff) in 0,001 kWh
Meter Reading electricity delivered to client                       1-0:1.8.2.255
 (normal tariff) in 0,001 kWh
Meter Reading electricity delivered by client                       1-0:2.8.1.255
 (low tariff) in 0,001 kWh
Meter Reading electricity delivered by client                       1-0:2.8.2.255
 (normal tariff) in 0,001 kWh
Tariff indicator electricity.                                       0-0:96.14.0.255
  The tariff indicator can be used to switch tariff dependent loads
  e.g boilers. This is responsibility of the P1 user 
Actual electricity power delivered (+P) in 1 Watt resolution        1-0:1.7.0.255
Actual electricity power received (-P) in 1 Watt resolution         1-0:2.7.0.255
Number of power failures in any phases                              0-0:96.7.21.255
Number of long power failures in any phases                         0-0:96.7. 9.255
Power failure event log                                             1-0:99:97.0.255
Number of voltage sags in phase L1                                  1-0:32.32.0.255
Number of voltage sags in phase L2                                  1-0:52.32.0.255
Number of voltage sags in phase L3                                  1-0:72.32.0.255
Number of voltage swells in phase L1                                1-0:32.36.0.255
Number of voltage swells in phase L2                                1-0:52.36.0.255
Number of voltage swells in phase L3                                1-0:72.36.0.255
Instantaneous voltage L1                                            1-0:32.7.0.255
Instantaneous voltage L2                                            1-0:52.7.0.255
Instantaneous voltage L3                                            1-0:72.7.0.255
Instantaneous current L1                                            1-0:31.7.0.255
Instantaneous current L2                                            1-0:51.7.0.255
Instantaneous current L3                                            1-0:71.7.0.255
Instantaneous active power L1 (+P)                                  1-0:21.7.0.255
Instantaneous active power L2 (+P)                                  1-0:41.7.0.255
Instantaneous active power L3 (+P)                                  1-0:61.7.0.255
Instantaneous active power L1 (-P)                                  1-0:22.7.0.255
Instantaneous active power L2 (-P)                                  1-0:42.7.0.255
Instantaneous active power L3 (-P)                                  1-0:62.7.0.255

## Messages
Text message max 1024 characters.                                   0-0:96.13.0.255

## Gas data
Device-Type                                                         0-n:24.1.0.255
Equipment identifier                                                0-n:96.1.0.255
Last 5-minute value (temperature converted),                        0-n:24.2.1.255
  gas delivered to client in m3, including decimal values
  and capture time

## Thermal data
Device-Type                                                         0-n:24.1.0.255
Equipment identifier                                                0-n:96.1.0.255
Last 5-minute Meter reading Heat or Cold in 0,01 GJ                 0-n:24.2.1.255
  and capture time

## Water P1
Device-Type                                                         0-n:24.1.0.255
Equipment identifier                                                0-n:96.1.0.255
Last 5-minute Meter reading in 0,001 m3 and capture time            0-n:24.2.1.255

## MBus device (ie. Slave meter)
Device-Type 4th M-Bus device                                        0-n:24.1.0.255
Equipment identifier                                                0-n:96.1.0.255
Last 5-minute Meter reading and capture time                        0-n:24.2.1.255
