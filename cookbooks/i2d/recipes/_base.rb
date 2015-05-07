
base_packages=%w(apt vim lsof curl wget ncdu ack-grep elinks git)
package base_packages

include_recipe "i2d::_users"
include_recipe "i2d::_sudoers"
include_recipe "openssh::default" # Allow password_authentication

execute "update system time" do
  command 'ntpdate ntp.ubuntu.com'
  user 'root'
end

include_recipe "i2d::_r53"
