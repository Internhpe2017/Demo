class git_install::git {


        Exec{
            path=>["/usr/bin","/bin","/usr/sbin","/opt/software/git-2.12.0",]
        }


                file { "/opt/software/git-2.12.tar.gz":
                ensure => "present",
                source => "puppet:///modules/git_install/git-2.12.tar.gz",
                owner => root,
                mode => 755
                     }->
                exec { "git_files untar" :
                cwd => "/opt/software",
                command => "tar -xzf git-2.12.tar.gz",
                }->
                exec { "configure" :
                cwd => "/opt/software/git-2.12.0",
                command => "make configure",
                }->
		exec { "configure2" :
                cwd => "/opt/software/git-2.12.0",
                command => "./configure --prefix=/usr/local",
                }->
		exec { "makeinstall" :
                cwd => "/opt/software/git-2.12.0",
                command => "make install",
                }


}
