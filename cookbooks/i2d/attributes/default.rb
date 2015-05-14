default['user']['ssh_keygen'] = false
default[:i2d][:domain]    = 'cheffian.com'
default[:i2d][:zone_id]   = 'Z1HCXNIVIGULVU'

default[:route53][:aws_region] =  'us-east-1'
default[:openssh][:server][:subsystem] = 'sftp /usr/libexec/sftp-server'
