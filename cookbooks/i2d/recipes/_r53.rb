include_recipe 'route53'

# full nodename record
route53_record "#{node[:cheffian][:role]}.#{node[:cheffian][:org]}" do
  name        "#{name}.#{node[:i2d][:domain]}."
  value       node[:ec2][:public_hostname]
  zone_id     node[:i2d][:zone_id]
  type        'CNAME'
  ttl         300
  overwrite   true
  action      :create
end
