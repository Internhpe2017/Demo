class jfroginstall::install
{
    
 user { "jfrog":
                 ensure => "present",
                 shell  => '/bin/bash',
                  home  => '/home/jfrog',
            managehome  => true,
                     }->
 file { '/opt/software/jfrog':
           ensure => 'directory',
           group   => 'jfrog',
           owner  => 'jfrog',
            mode  => '755',
          }

 file{"/opt/software/jfrog/jfrog-artifactory-oss-5.1.3.zip":
       require => File['/opt/software/jfrog'],
      source=>'puppet:///modules/jfroginstall/jfrog-artifactory-oss-5.1.3.zip',
        ensure=>'present',
        group => 'jfrog',
        owner => 'jfrog',
        mode => 755,
     }->

#exec{"unzip":
	#cwd=>'/opt/software/jfrog/',
	#path=>["/usr/bin", "/usr/sbin", "/bin","/sbin","/usr"],
    # command=>"unzip jfrog-artifactory-oss-5.1.3.zip",
            
    # }->

 exec { 'remove':
	path=>["/usr/bin", "/usr/sbin", "/bin","/sbin","/usr"],
	cwd=> "/opt/software/jfrog/artifactory-oss-5.1.3/bin",
	command => "rm -f artifactory.default",
     }->

 file { '/opt/software/jfrog/artifactory-oss-5.1.3/bin/artifactory.default':
	require => Exec["remove"],
	ensure => present,
	content => template('jfroginstall/artifactory.default'),
     }->

 exec { 'permission':
	#require => File["/opt/jfrog/artifactory-oss-4.6.0/bin/artifactory.default"],
	path    => ["/sbin","/usr","/usr/bin", "/usr/sbin", "/bin"],
	cwd => "/opt",
	command => "chmod -R 755 *",
 }->
exec { 'ownership':
  require => Exec["permission"],
  path    => ["/usr","/bin","/sbin","/usr/bin", "/usr/sbin"],
  command => "chown -R jfrog:jfrog /opt/software/jfrog",
  }->

 
exec{"installservice":
	path=>["/usr/bin", "/usr/sbin", "/bin","/sbin","/usr"],
       # path=>["/usr/bin", "/usr/sbin", "/bin","/sbin","/usr","/opt/software/jfrog/artifactory-oss-4.6.0/bin"],
        cwd=>'/opt/software/jfrog/artifactory-oss-5.1.3/bin',
     #command=>"./installService.sh jfrog",
     command=>"/opt/software/jfrog/artifactory-oss-5.1.3/bin/installService.sh jfrog",

    }->

exec{"switchuser":
	path=>["/usr","/bin","/sbin","/usr/bin","/usr/sbin"],
	command=> "su jfrog",
}->
 exec { 'run':
	path => ["/usr","/bin","/sbin","/usr/bin","/usr/sbin"],
          command => "service artifactory start",
      }   
   }
