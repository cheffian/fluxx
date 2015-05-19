#
# Cookbook Name:: i2d_aws
# Recipe:: ws
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Workstation Recipe

# The node needs to instantiate with at least the following
# bits of information
# - role: which could be based on launch config, e.g. 'id2_ws'
# - chef_environment: e.g. 'fluxx'
# - IAM privileges to self-provision: 'ws.kfluxx.cheffian.com
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

i2d_role = 'ws.' + org
Chef::Log.info("i2d_role: #{i2d_role}")

with_driver 'aws::us-east-1' do
  aws_security_group i2d_role do
    description      name
    inbound_rules   '0.0.0.0/0' => 22
    #inbound_rules   '71.178.0.0/16' => 22
  end

  machine i2d_role do
    action :allocate

    add_machine_options bootstrap_options: {
      instance_type: 'm1.small',
      image_id: 'ami-d85e75b0',
      security_groups: [ i2d_role ],
      iam_instance_profile: 'cheffian-ec2-bootstrap',
      key_name: 'divdevops_workshop',
      user_data: user_data
    }
  end

end
