class tomcat_install::tomcat {


        Exec{
            path=>["/usr/bin","/bin","/usr/sbin"]
        }


                file { "/opt/software/tomcat.tar.gz":
                ensure => "present",
                source => "puppet:///modules/tomcat_install/tomcat.tar.gz",
                owner => root,
                mode => 755
                     }->
                exec { "tomcat_files untar" :
                cwd => "/opt/software",
                command => "tar -xzf tomcat.tar.gz",
                }->
                exec { "tomcat_rpm localinstall" :
                cwd => "/opt/software/tomcat",
                command => "yum localinstall *.rpm -y",
                }

}

