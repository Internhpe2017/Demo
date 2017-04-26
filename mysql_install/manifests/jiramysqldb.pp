class mysql_install::jiramysqldb
{

exec {"createdb":
                command => "/usr/bin/mysql -uroot -pAdmin@123 -e \"CREATE DATABASE jiradb CHARACTER SET utf8 COLLATE utf8_bin;
create user jira identified by 'Admin@123';
GRANT ALL PRIVILEGES ON jiradb.* to jira@127.0.0.1 identified by 'Admin@123';
GRANT ALL PRIVILEGES ON jiradb.* to jira@192.168.237.142 identified by 'Admin@123';
GRANT ALL PRIVILEGES ON jiradb.* to jira@host142.interns.hpe identified by 'Admin@123';
GRANT ALL PRIVILEGES ON jiradb.* to jira@localhost identified by 'Admin@123';
flush privileges;\"",
                }

}

