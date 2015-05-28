# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Attributes:: default
#

# where to do some install work
default[:valhalla][:base_dir]                                    = '/opt/valhalla'
default[:valhalla][:tile_dir]                                    = "#{node[:valhalla][:base_dir]}/tiles"
default[:valhalla][:log_dir]                                     = "#{node[:valhalla][:base_dir]}/log"
default[:valhalla][:conf_dir]                                    = "#{node[:valhalla][:base_dir]}/etc"
default[:valhalla][:src_dir]                                     = "#{node[:valhalla][:base_dir]}/src"
default[:valhalla][:lock_dir]                                    = "#{node[:valhalla][:base_dir]}/lock"
default[:valhalla][:extracts_dir]                                = "#{node[:valhalla][:base_dir]}/extracts"

# the repos
default[:valhalla][:github][:base]                               = 'https://github.com/valhalla'
default[:valhalla][:github][:revision]                           = 'master'

# valhalla user to create
default[:valhalla][:user][:name]                                 = 'valhalla'
default[:valhalla][:user][:home]                                 = '/home/valhalla'

# the data to create tiles
default[:valhalla][:extracts]                                    = %w(
  http://download.geofabrik.de/europe/liechtenstein-latest.osm.pbf
)
default[:valhalla][:with_updates]                                = 'no'

# where to put fresh tiles and who wants them
default[:valhalla][:bucket]                                      = 'mapzen.valhalla'
dafault[:valhalla][:bucket_dir]                                  = 'dev'
default[:valhalla][:service_stack]                               = '978e7e69-0c63-46da-9e12-39a25a1f6078'
default[:valhalla][:service_layer]                               = 'c39b1588-3824-464e-9fbc-99d9882e39cc'
default[:valhalla][:service_recipes]                             = '[\'fresh_tiles\']'

# configuration
default[:valhalla][:config]                                      = "#{node[:valhalla][:conf_dir]}/valhalla.json"
default[:valhalla][:mjolnir][:concurrency]                       = node[:cpu][:total]
default[:valhalla][:httpd][:listen_address]                      = '0.0.0.0'
default[:valhalla][:httpd][:port]                                = 8080

# workers
default[:valhalla][:workers][:count]                             = 8 # int, > 0
