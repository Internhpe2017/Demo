class install_jira::jiracode
{
# atlassian (1.bin)+jdk(1.rpm)+mysql(4.rpm)+mysql_connector(1.jar)
$bin = "atlassian-jira-software-7.2.3-x64.bin"
	exec{"expect":
		 command=>"yum install expect -y",
                 path=>["/bin/","/sbin/","/usr/bin/","/usr/sbin/",],
	
	}
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

#	service {'jira':
#	require => Exec["script "],
#	start => "service jira start",
#	ensure => 'running',
#	}
#	service {'jira status':
 #       require => Exec["jira"],
  #      start => "service jira status",
   #     }


}
=======
class install_java
{
        $rpm = "jdk-8u121-linux-x64.rpm"
        file{"$rpm":
                        path =>"/opt/software/$rpm",
                        source=>"puppet:///modules/installjava/$rpm",
                        ensure=>present,
        }
        exec{"rpm -ivh /opt/software/$rpm":
			command=>'rpm -ivh /opt/software/$rpm',
                        cwd=>'/usr/',
                        creates=>'/usr/java/jdk1.8.0_121',
                        path=>['/usr/bin','/usr/sbin',],
        }
}



