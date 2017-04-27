class tomcat_install::tomcat_dependencies {
	
	require 'tomcat_install::tomcat'

        Exec{
            path=>["/usr/bin","/bin","/usr/sbin"]
        }


                file { "/opt/software/tomcat-web-interface.tar.gz":
                ensure => "present",
                source => "puppet:///modules/tomcat_install/tomcat-web-interface.tar.gz",
                owner => root,
                mode => 755
                     }->
                exec { "tomcat-dependencies untar" :
                cwd => "/opt/software",
                command => "tar -xzf tomcat-web-interface.tar.gz",
                }->
                exec { "tomcat-dependencies localinstall" :
                cwd => "/opt/software/tomcat-web-interface",
                command => "yum localinstall *.rpm -y",
                }->
		file { "changing port":
		path => "/etc/tomcat/server.xml",
		content => template("tomcat_install/server.xml"),
		owner => "root",
		group => "tomcat",
		mode => 644,
		}->
		file { "users xml file":
                path => "/etc/tomcat/tomcat-users.xml",
                content => template("tomcat_install/tomcat-users.xml"),
                owner => "root",
		group => "tomcat",
		mode => 640,
		}->
		exec { "starting tomcat service" :
		command => "service tomcat start",
		}

}
