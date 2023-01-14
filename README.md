# Collectd Shell Scripts

A set of shell scripts that can be used with the [Collectd](http://collectd.org)/[Collectd on github](https://github.com/collectd/collectd) Exec plugin

## Enable Exec plugin

```
cat <EOF> /etc/collectd/collectd.conf.d/exec.conf
# Note: Config must end with a BLANK line!
LoadPlugin exec
<Plugin exec>
    Exec "collectd" "/usr/local/bin/net2collectd" "P1DSMR" "smartmeter.iot.lan:2000"
    Exec "collectd" "/usr/local/bin/net2collectd" "P1WarmteNet" "smartmeter.iot.lan:2001"
</Plugin>

```

## net2collectd

A script that takes the output of a P1 connection via [ser2net](https://github.com/cminyard/ser2net) and converts it to the collectd test protocol.

### Requirements

You need to setup the ser2net daemon on a system that has the P1 connection(s) to your smart meter(s).
Packages/Applications needed:
```
bc
nc
```
For *netcat*(nc), check the [Possible issues](#possible-issues) section below.

### Install

Clone the repo and copy the net2collectd script to `/usr/local/bin/`:
```
git clone 
sudo cp sh-collectd/net2collectd /usr/local/bin
sudo chmod 755 /usr/local/bin/net2collectd
```

Add the following to `/etc/collectd/collectd.conf.d/exec.conf`:
```
<Plugin exec>
    Exec "collectd" "/usr/local/bin/net2collectd" "P1DSMR" "smartmeter.iot.lan:2000"
    Exec "collectd" "/usr/local/bin/net2collectd" "P1WarmteNet" "smartmeter.iot.lan:2001"
</Plugin>
```
  **!!** Change hostnames (*P1DSMR*, *P1WarmteNet*) to your own standards as these will show up in your rrd basedir. Also change the *smartmeter.iot.lan:port* to the hostname ans port where your `ser2net` daemon reside. Ofcourse, they can be different hosts if you use more than one.

Restart collectd
```
service collectd restart
sleep 5
service collectd status
```
Fix any errors you see.

### Possible issues

The busybox netcat is too limited for use in non-interactive scripts. Install a full version (ie: `apk add netcat-openbsd` for Alpine Linux).
