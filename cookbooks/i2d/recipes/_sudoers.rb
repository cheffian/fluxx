node.default['authorization']['sudo']['groups'] = ['devops']
node.default['authorization']['sudo']['passwordless'] = true

include_recipe "sudo::default"
