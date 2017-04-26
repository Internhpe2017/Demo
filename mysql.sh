#!/bin/bash
expect -c"
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"

expect \"Set root password?\"
send \"y\r\"

expect \"New password:\"
send \"Admin@123\r\"

expect \"Re-enter new password:\"
send \"Admin@123\r\"


expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"n\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

puts \"Ended expect script.\"
"

# 3.) create .ran file indicating mysql was secured

#touch `which mysql_secure_installation`.ran
