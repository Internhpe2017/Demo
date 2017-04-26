#!/bin/bash
expect -c"
spawn htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
expect \"New password:\"
send \"admin@123\r\"

expect \"Re-type new password:\"
send \"admin@123\r\"





puts \"Ended expect script.\"
"

