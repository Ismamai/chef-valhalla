# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Recipe:: default
#

include_recipe 'apt::default'

package 'git'

%w(
  user::default
  runit::default
  valhalla::setup
  valhalla::install
).each do |r|
  include_recipe r
end
