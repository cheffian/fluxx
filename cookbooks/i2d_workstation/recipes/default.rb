#
# Cookbook Name:: i2d_workstation
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


include_recipe "i2d_base::base"
include_recipe "i2d_base::users"
include_recipe "i2d_base::sudoers"
include_recipe "openssh::default" # Allow password_authentication


## ChefDK:
include_recipe "chef-dk"
template '/etc/profile.d/chefdk.sh' do
  mode "0644"
  source "bash_profile.erb"
end

  # docker?
