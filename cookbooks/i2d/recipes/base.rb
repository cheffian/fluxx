
base_packages=%w(apt vim lsof curl wget ncdu ack-grep elinks git tree)
package base_packages

include_recipe "apt"

execute "update system time" do
  command 'ntpdate ntp.ubuntu.com'
  user 'root'
end

if node[:i2d][:route53]
  include_recipe "i2d::_r53"
end
