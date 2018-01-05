# check_last_yum
Nagios plugin to check for yum package manager activity

```
# no recent activity in the last 15 minutes
$ /opt/nagios/custom-plugins/check_last_yum -w 15
OK - Karl <kjbweb> performed Update affecting 1 packages on 2018-01-04 16:05

# removal of a package
$ /opt/nagios/custom-plugins/check_last_yum -w 15
WARNING - Karl <kjbweb> performed Erase affecting 1 packages on 2018-01-05 11:36

# install of a package
$ /opt/nagios/custom-plugins/check_last_yum -w 15
WARNING - Karl <kjbweb> performed Install affecting 1 packages on 2018-01-05 11:37
```

### Description
I created this script to use Nagios to keep tabs on an estate which experienced a lot of unmanaged change.

I found once deployed it became invaluable when combined with other service checks; for instance when alerts start rolling in after a package gets upgraded unintentionally...

The plugin will only generate warnings currently as this is part of our informational suite of checks (last user, software versions, etc...).

### Usage
This plugin requires sudo privliges to call and parse yum's history.

If you're invoking this script using NRPE as the user `nrpe`, place a file containing the following under `/etc/sudoers.d`:
```
nrpe	ALL=NOPASSWD: /opt/nagios/custom-plugins/check_last_yum
```

The nrpe config line for this should look something like the following:
```
command[check_last_yum]=/usr/bin/sudo /opt/nagios/custom-plugins/check_last_yum -w 15
```

This script will not produce critical alerts (unless you modify it), the alerts are intended for informational purposes only:
```
# Usage: check_last_yum [-w minutes]
#   -w, --warning WARNING	Warning threshold in minutes
#   -h, --help			Display this screen
```
