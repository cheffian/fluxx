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
#     - I'll

require 'chef/provisioning/aws_driver'
require_relative '../libraries/helpers'

role = 'ws.munchlax'

with_driver 'aws::us-east-1' do
  aws_security_group role do
    description      name
    inbound_rules   '0.0.0.0/0' => 22
  end

  machine role do
    action :allocate

    add_machine_options bootstrap_options: {
      instance_type: 'm1.small',
      image_id: 'ami-d85e75b0',
      security_groups: [ role ],
      iam_instance_profile: 'pburkholder-ec2-bootstrap',
      key_name: 'pburkholder-one',
      user_data: user_data
    }
  end

end