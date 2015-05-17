#
# Cookbook Name:: i2d_web
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# The i2d_web::core recipe does all the web stuff
# and is easily tested.  This default recipe
# includes the base stuff for EC2 production:
#   packages, route53, ntp, apt

include_recipe "i2d_base::base"
include_recipe "i2d_web::core"
