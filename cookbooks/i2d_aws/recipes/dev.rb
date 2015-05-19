#
# Cookbook Name:: i2d_aws
# Recipe:: ws
# Copyright (c) 2015 The Authors, All Rights Reserved.

# webdev recipe

require 'chef/provisioning/aws_driver'
require_relative '../libraries/helpers'
locale = 'excella'

i2d_role = 'dev.' + org
Chef::Log.info("i2d_role: #{i2d_role}")


with_driver 'aws::us-east-1' do
  aws_security_group i2d_role do
    description      name
    inbound_rules   [
      { port: 22, protocol: :tcp, sources: [ cidr_block(locale), cidr_block('home'), "ws.#{org}" ] },
      { port: 80, protocol: :tcp, sources: [ cidr_block(locale), "ws.#{org}" ] },
    ]
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
