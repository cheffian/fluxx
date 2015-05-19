#!/bin/sh -xve

# ssh ubuntu@chefserver.cheffian.org
# for org in 

orgs="fluxx milk rocket moon sun peace time brain dream party bread money"
repo=/Users/pburkholder/Projects/cheffian/fluxx

create_org() {
  sudo chef-server-ctl org-create $chef_org $chef_org \
      -f $chef_org.pem -a pdb -a jenkins
  for user in pdb jenkins; do
      sudo chef-server-ctl org-user-add $chef_org -a $user
  done
}

copy_pem() {
  if  [ -f $HOME/.chef/cheffian/$chef_org.pem ]
    echo COPY_PEM: $chef_org.pem already here
  else
    scp ubuntu@chefserver.cheffian.com:$chef_org.pem \
    $HOME/.chef/cheffian
  fi
}

policy() {
  prior=`pwd`

  cd $repo/cookbooks
    berks upload
    berks vendor
  
  cd $repo

  for role in roles/*json; do 
    knife role from file $role; 
  done

  cd $prior
}

nodes() {
  chef-client -z $repo/cookbooks/i2d_aws/recipes/ws.rb
  chef-client -z $repo/cookbooks/i2d_aws/recipes/dev.rb
}

for chef_org in $orgs; do
  echo $chef_org
  export CHEF_SERVER=$chef_org
  export CHEF_SERVER_ORG=$chef_org

  #create_org
  copy_pem
  policy
  nodes
done
