# Notes

## Collectd
### Types.db
> Each line consists of two fields delimited by spaces and/or horizontal tabs. The first field defines the name of the data-set, while the second field defines a list of data-source specifications, delimited by spaces and, optionally, a comma (",") right after each list-entry.
> 
> The format of the data-source specification has been inspired by RRDtool's data-source specification. Each data-source is defined by a *quadruple* made up of the **data-source name**, **type**, **minimal and maximal** values, delimited by colons (":"):
> **ds-name**:**ds-type**:**min**:**max**
> Example:
>  df                      used:GAUGE:0:1125899906842623, free:GAUGE:0:1125899906842623
>
> *ds-type* may be either ABSOLUTE, COUNTER, DERIVE, or GAUGE. min and max define the range of valid values for data stored for this data-source. If U is specified for either the min or max value, it will be set to unknown, meaning that no range checks will happen. See rrdcreate(1) for more details.


```
Jan 13 02:21:49 SmartPi collectd[10693]: -1 1 Type `used' isn't defined.
Jan 13 02:21:49 SmartPi collectd[10693]: -1 1 Type `delivered' isn't defined.
Jan 13 02:21:49 SmartPi collectd[10693]: -1 1 Type `received' isn't defined.
Jan 13 02:21:50 SmartPi collectd[10693]: -1 1 Type `failures' isn't defined.
Jan 13 02:21:50 SmartPi collectd[10693]: -1 1 Type `L1' isn't defined.
Jan 13 02:21:50 SmartPi collectd[10693]: -1 1 Type `last5m' isn't defined.
Jan 13 02:21:51 SmartPi collectd[10693]: -1 1 Type `instantaneous' isn't defined.
```