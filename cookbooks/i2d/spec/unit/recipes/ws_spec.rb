#
# Cookbook Name:: i2d
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'i2d::ws' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set[:cheffian][:role] = 'ws'
        node.set[:cheffian][:org] =  'fluxx'
        node.automatic[:ec2][:public_hostname] = 'ec2.aws'
      end

      runner.converge(described_recipe)
    end

    before do
      stub_command("which sudo").and_return('/bin/sudo')
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

  end
end
