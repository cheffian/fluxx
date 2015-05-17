#
# Cookbook Name:: i2d_web
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# See https://github.com/chef-cookbooks/httpd

package 'apache2'

service 'apache2' do
  action [ :enable, :start ]
end

#httpd_service 'default' do
#  action [:create, :start]
#end
