class jira 
{
	require 'java'
	require 'Mysql'
        $bin = "atlassian-jira-software-7.2.3-x64.bin"
        file { '/opt/software/jira/':
                        ensure => 'directory',
                        mode   => '0750',
                }

        file{"$bin":
                        path =>"/opt/software/jira/$bin",
                        source=>"puppet:///modules/jira/files/{$bin}",
                        ensure=>present,
			mode=>755,
        }
       /* exec{"chmod 755 $bin":
                         cwd=>'/opt/software/jira',
                       command=>'chmod 755 atlassian-jira-software-7.2.3-x64.bin',
                        path=>['/usr/bin','/usr/sbin',],
        }*/
         exec{"./$bin":
                        #cwd=>'/opt/software/jira/',
                        command=>'/opt/software/jira/atlassian-jira-software-7.2.3-x64.bin',
                        path=>['/bin/','/sbin/','/usr/bin/','/usr/sbin/','/opt/software/jira/',],
        }

}



