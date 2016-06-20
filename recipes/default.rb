# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Recipe:: default
#

include_recipe 'apt::default'

package 'git'

%w(
  user::default
  valhalla::setup
  valhalla::install_from_source
).each do |r|
  include_recipe r
end
