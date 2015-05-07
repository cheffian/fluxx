include_recipe 'route53'

# full nodename record
route53_record "#{node.name}.#{node.chef_environment}" do
  name        "#{name}.#{node[:i2d][:domain]}."
  value       node[:ec2][:public_hostname]
  zone_id     node[:i2d][:zone_id]
  type        'CNAME'
  ttl         300
  overwrite   true
  action      :create
end

shorthand = node.name.sub(/-i-.*/, '')
route53_record "#{shorthand}.#{node.chef_environment}" do
  name        "#{name}.#{node[:i2d][:domain]}."
  value       node[:ec2][:public_hostname]
  zone_id     node[:i2d][:zone_id]
  type        'CNAME'
  ttl         300
  overwrite   true
  action      :create
end
