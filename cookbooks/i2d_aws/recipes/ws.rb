#
# Cookbook Name:: i2d_aws
# Recipe:: ws
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Workstation Recipe

# The node needs to instantiate with at least the following
# bits of information
# - role: which could be based on launch config, e.g. 'id2_ws'
# - chef_environment: e.g. 'munchlax'
# - IAM privileges to self-provision: 'ws-munchlax.chefdemo.net'
#
# Passing the role & environment with tags would require that the
# node itself have the IAM privileges to read tags. I'll try first
# to do it with security group 'role.environment'
# security_group 'ws.munchlax' do
# end
#
# Also, three users: alpha, bravo and charlie
#   - need to use password authentication
#

with_driver 'aws::us-east-1' do
  aws_launch_configuration 'i2d_ws' do
    image 'ami-d85e75b0'  # Trusty
    instance_type 'm3.small'
    options({
      security_groups: ['sg-2ee7694b'],
      key_pair: 'pburkholder-one',
      user_data: user_data
    })
  end

  aws_auto_scaling_group 'peterb-sensu-master' do
    desired_capacity 1
    min_size 1
    max_size 1
    launch_configuration 'peterb-sensu-master'
    availability_zones ['us-east-1c']
  end
end
