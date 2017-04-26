class install_java::javacode
{
	file{"/opt/software/jira/jdk-8u121-linux-x64.rpm":
		ensure=>'present',
		source=>"puppet:///modules/install_java/jdk-8u121-linux-x64.rpm",
	     }
	exec{'extract jdk':
		require=>File["/opt/software/jira/jdk-8u121-linux-x64.rpm"],
		command=>"rpm -ivh /opt/software/jira/jdk-8u121-linux-x64.rpm",
		creates=>"/usr/java/jdk1.8.0_121/bin",
	        path=>["/bin","/sbin","/usr/bin","/usr/sbin",],
		}
}

