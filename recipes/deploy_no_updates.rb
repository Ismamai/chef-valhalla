# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Recipe:: deploy
#

# the list of the files we will be importing
files = node[:valhalla][:extracts].map { |url| url.split('/').last }
extracts = node[:valhalla][:extracts_dir] + '/' + files.join(' ' + node[:valhalla][:extracts_dir] + '/')

cron "add deploy cron" do
  minute "*/5"
  user "#{node[:valhalla][:user][:name]}"
  command "cd #{node[:valhalla][:base_dir]}; #{node[:valhalla][:src_dir]}/mjolnir/scripts/deploy_no_updates.sh #{node[:valhalla][:base_dir]} #{node[:valhalla][:conf_dir]}/#{node[:valhalla][:config]} #{node[:valhalla][:src_dir]} #{node[:valhalla][:extracts_dir]} #{node[:valhalla][:log][:mjolnir]} >> #{node[:valhalla][:log_dir]}/deploy_cron.log 2>&1"
end

