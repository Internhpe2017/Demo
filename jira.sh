#!/bin/bash
expect -c"
spawn /opt/software/jira/atlassian-jira-software-7.2.3-x64.bin

expect \"OK [o, Enter], Cancel [c]\"
send \"\r\"

expect \"Express Install (use default settings) [1], Custom Install (recommended for advanced users) [2, Enter], Upgrade an existing JIRA installation [3]\"
send \"2\r\"

expect \"[/opt/atlassian/jira]\"
send \"\r\"

expect \"[/var/atlassian/application-data/jira]\"
send \"\r\"

expect \"Use default ports (HTTP: 8080, Control: 8005) - Recommended [1, Enter], Set custom value for HTTP and Control ports [2]\"
send \"2\r\"

expect \"[8080]\r\"
send \"8091\r\"

expect \"[8005]\r\"
send \"8006\r\"

expect \"Yes [y, Enter], No [n]\"
send \"Yes\r\"

expect \"Install [i, Enter], Exit [e]\"
send \"i\r\"

expect \"Yes [y, Enter], No [n]\"
send \"Yes\r\"
"
