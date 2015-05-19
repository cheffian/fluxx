require 'spec_helper'

describe 'i2d_web::core' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  describe service('apache2') do
    it { should be_running }
    it { should be_enabled }
  end

#  describe command('curl -s http://localhost') do
#    its(:stdout) { should_not contain('Ubuntu') }
#  end

end
