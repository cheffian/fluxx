#
# Cookbook Name:: i2d
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'i2d_workstation::default' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set[:i2d_base][:route53] = false
#        node.automatic[:ec2][:public_hostname] = 'ec2.aws'
      end

      runner.converge(described_recipe)
    end

    before do
      stub_command("which sudo").and_return('/bin/sudo')
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'should include chefdk' do
      expect(chef_run).to include_recipe('chef-dk')
    end

    it 'should set chefdk path stuff' do
      expect(chef_run).to render_file('/etc/profile.d/chefdk.sh')
    end
  end
end
