default['user']['ssh_keygen'] = false
default[:i2d_base][:domain]    = 'devopsdc.com'
default[:i2d_base][:zone_id]   = 'Z3ETJH5R2QKF17'
default[:i2d_base][:route53]   = true
default[:route53][:aws_region] =  'us-east-1'
default[:openssh][:server][:subsystem] = 'sftp /usr/libexec/sftp-server'
