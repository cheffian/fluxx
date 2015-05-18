#
# Cookbook Name:: learnchef_docker
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# Source: learnchef/introduction_to_chef/instructor/ \
#    chef-repo/cookbooks/learn/chef_docker/recipes/default.rb

node.default['docker']['docker_daemon_timeout'] = 600
node.default['docker']['exec_driver'] = "lxc"

include_recipe "docker::default"

gem_package 'kitchen-docker' do
  gem_binary '/opt/chefdk/embedded/bin/gem'
end

# TODO:  is there a way to get a clean docker install without requiring this?
execute "clean-up docker" do
  command <<-EOH
    service docker stop
    rm -rf /var/lib/docker
    service docker start
  EOH
end

docker_image "ubuntu" do
  cmd_timeout 3000
  ignore_failure true
  tag 'latest'
end
