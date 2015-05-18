#
# Cookbook Name:: i2d_aws
# Recipe:: ws
# Copyright (c) 2015 The Authors, All Rights Reserved.

# webdev recipe

require 'chef/provisioning/aws_driver'
require_relative '../libraries/helpers'
locale = 'home'

i2d_role = 'dev.' + org
Chef::Log.info("i2d_role: #{i2d_role}")


with_driver 'aws::us-east-1' do
 
  machine i2d_role do
    action :destroy
  end

#  aws_security_group i2d_role do
#    action :destroy
#  end
end
