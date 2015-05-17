#
# Cookbook Name:: i2d_web
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'i2d_web::core' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set[:i2d_base][:route53] = false
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs, starts httpd/apaches' do
      expect(chef_run).to install_package('apache2')
      expect(chef_run).to enable_service('apache2')
    end

  #  it 'uses the httpd_service' do
  #    expect(chef_run).to create_httpd_service('default')
  #  end

  end
end
