default['user']['ssh_keygen'] = false
default[:i2d_base][:domain]    = 'cheffian.com'
default[:i2d_base][:zone_id]   = 'Z1HCXNIVIGULVU'
default[:i2d_base][:route53]   = true
default[:route53][:aws_region] =  'us-east-1'
default[:openssh][:server][:subsystem] = 'sftp /usr/libexec/sftp-server'
