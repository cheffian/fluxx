require 'chef/provisioning/aws_driver'
require_relative '../libraries/helpers'

i2d_role = 'ws.munchlax'
with_driver 'aws::us-east-1' do
  aws_auto_scaling_group i2d_role do
    action :delete
  end
  aws_launch_configuration i2d_role do
    action :delete
  end
end
