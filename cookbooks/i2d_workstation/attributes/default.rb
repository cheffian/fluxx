default['user']['ssh_keygen'] = false
default[:route53][:aws_region] =  'us-east-1'
default[:openssh][:server][:subsystem] = 'sftp /usr/libexec/sftp-server'
