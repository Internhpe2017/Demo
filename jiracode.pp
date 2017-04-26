class install_jira::jiracode
{
# atlassian (1.bin)+jdk(1.rpm)+mysql(4.rpm)+mysql_connector(1.jar)
$bin = "atlassian-jira-software-7.2.3-x64.bin"
	file{'/opt/software/jira':
        	ensure => 'directory',
		mode => '755',
	
	}
	file{"$bin":
			path=>"/opt/software/jira/$bin",
                        source=>"puppet:///modules/install_jira/$bin",
                        ensure=>present,
			mode=>'755'
        }
	file {"jira.sh":
		path=>"/opt/software/jira/jira.sh", 
		ensure=>"file",
		source => 'puppet:///modules/install_jira/jira.sh',
		mode => '0777',
	}

	exec{"script ":
   		require => File["jira.sh"],
	path => ["/sbin/","/usr/bin/","/usr/sbin/","/bin/bash/","/bin/","/usr/local/bin/"],	
	cwd=>"/opt/software/jira/",
	command=>"/opt/software/jira/jira.sh",
	}

	file {"mysqlconnector":
                path=>"/opt/atlassian/jira/lib/mysql-connector-java-5.1.40-bin.jar",
		ensure=>'present',
                source => "puppet:///modules/install_jira/mysql-connector-java-5.1.40-bin.jar",
                mode => '0777',
        }
}


