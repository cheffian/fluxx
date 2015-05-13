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

role = 'ws.fluxx'

with_driver 'aws::us-east-1' do
  machine role do
    action :destroy
  end

end
