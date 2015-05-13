#
# Cookbook Name:: i2d_aws
# Recipe:: ws
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Workstation Recipe

# The node needs to instantiate with at least the following
# bits of information
# - role: which could be based on launch config, e.g. 'id2_ws'
# - chef_environment: e.g. 'fluxx'
# - IAM privileges to self-provision: 'ws-fluxx.cheffian.com'
#
# Passing the role & environment with tags would require that the
# node itself have the IAM privileges to read tags. I'll try first
# to do it with security group 'role.environment'
# security_group 'ws.fluxx' do
# end
#
# Also, three users: alpha, bravo and charlie
#   - need to use password authentication
#     - I'll

require 'chef/provisioning/aws_driver'
require_relative '../libraries/helpers'

i2d_role = 'ws.fluxx'

with_driver 'aws::us-east-1' do
  aws_security_group  i2d_role  do
    description     name
    inbound_rules   '0.0.0.0/0' => 22
  end

  aws_launch_configuration i2d_role do
    image 'ami-d85e75b0'  # Trusty
    instance_type 'm1.small'
    options({
      security_groups: [ i2d_role ],
      iam_instance_profile: 'pburkholder-ec2-bootstrap',
      key_pair: 'pburkholder-one',
      user_data: user_data
    })
  end

  aws_auto_scaling_group i2d_role do
    desired_capacity 1
    min_size 1
    max_size 2
    launch_configuration i2d_role
    availability_zones ['us-east-1c']
  end
end
