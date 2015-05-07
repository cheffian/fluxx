# determine dynamically:
#   - role: from security group, (role)-(environment)
#   - node name: "#{role}-#{instance_id}"
#   - environment: from security group

def org
  raise ArgumentError, 'Need env var: CHEF_SERVER_ORG' if ENV['CHEF_SERVER_ORG'].nil?
  ENV['CHEF_SERVER_ORG']
end

def chef_server_url
  "https://chefserver.cheffian.com/organizations/#{org}"
end

def validation_client_name
  org
end

def validation_pem
  File.read("#{ENV['HOME']}/.chef/cheffian/#{org}.pem")
end

def user_data
<<END_SCRIPT
#!/bin/bash -xv

# Install chef-client
curl -L https://www.opscode.com/chef/install.sh | bash /dev/stdin -v 12.3.0

# Give Ohai a hint about EC2
mkdir -p /etc/chef/ohai/hints
touch /etc/chef/ohai/hints/ec2.json

# Set up validation.pem
cat <<END_PEM>/etc/chef/validation.pem
#{validation_pem}
END_PEM

# Set up client.rb
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
security_groups=$(curl -s http://169.254.169.254/latest/meta-data/security-groups)

role=$(echo $security_groups | cut -f 1 -d.)
environment=$(echo $security_groups | cut -f 2 -d.)
node_name=$(printf "%s-%s\n" $role $instance_id)

cat <<END_CLIENT>/etc/chef/client.rb
log_level        :auto
chef_server_url  "#{chef_server_url}"
validation_client_name  "#{validation_client_name}"
node_name        "$node_name"
environment      "$environment"
END_CLIENT

# Set first boot JSON
cat <<END_JSON>/etc/chef/run_list.json
{"run_list":["role[$role]"]}
END_JSON

# Kick off chef run
/usr/bin/chef-client -j /etc/chef/run_list.json

# Fini
exit
END_SCRIPT
end # def user_data
