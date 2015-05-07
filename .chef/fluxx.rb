# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT

# node_name maps to my username when interacting w/ chefserver
node_name                "pdb"
client_key               "#{ENV['HOME']}/.chef/cheffian/pdb.pem"

chef_server_url          "https://chefserver.cheffian.com/organizations/fluxx"
cookbook_path            [
                            "#{current_dir}/..",
                            "#{current_dir}/../cookbooks"
                          ]
cache_path              "#{ENV['HOME']}/.chef/zero/cache"
