# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Attributes:: default
#

# where do some things belong
default[:valhalla][:base_dir]                                    = '/opt/valhalla'
default[:valhalla][:tile_dir]                                    = "#{node[:valhalla][:base_dir]}/tiles"
default[:valhalla][:log_dir]                                     = "#{node[:valhalla][:base_dir]}/log"
default[:valhalla][:conf_dir]                                    = "#{node[:valhalla][:base_dir]}/etc"
default[:valhalla][:temp_dir]                                    = "#{node[:valhalla][:base_dir]}/temp"
default[:valhalla][:src_dir]                                     = "#{node[:valhalla][:base_dir]}/src"
default[:valhalla][:lock_dir]                                    = "#{node[:valhalla][:base_dir]}/lock"
default[:valhalla][:extracts_dir]                                = "#{node[:valhalla][:base_dir]}/extracts"
default[:valhalla][:elevation_dir]                               = "#{node[:valhalla][:base_dir]}/elevation"
default[:valhalla][:transit_dir]                                 = "#{node[:valhalla][:base_dir]}/transit"

# the repos
default[:valhalla][:github][:base]                               = 'https://github.com/valhalla'
default[:valhalla][:github][:revision]                           = 'master'
default[:valhalla][:ppa_version]                                 = ''

# valhalla user to create
default[:valhalla][:user][:name]                                 = 'valhalla'
default[:valhalla][:user][:home]                                 = '/home/valhalla'

# the data to create tiles
default[:valhalla][:extracts]                                    = %w(
  http://download.geofabrik.de/europe/liechtenstein-latest.osm.pbf
)
default[:valhalla][:with_updates]                                = false
default[:valhalla][:with_transit]                                = false
default[:valhalla][:transitland_url]                             = 'http://transit.land'
default[:valhalla][:transitland_api_key]                         = ''
default[:valhalla][:transitland_import_level]                    = '4'

#map roulette
default[:maproulette][:config_file]                              = 'maproulette.json'
default[:maproulette][:geojson_file]                             = 'maproulette_tasks.geojson'
default[:maproulette][:recurring_tasks_file]                     = 'recurring_tasks_file.txt'
default[:maproulette][:server_url]                               = 'http://localhost:9000'
default[:maproulette][:run_admin_tool]                           = false
default[:maproulette][:api_key]                                  = 'YOUR_KEY'
default[:maproulette][:config]                                   = "#{node[:valhalla][:conf_dir]}/#{node[:maproulette][:config_file]}"
default[:maproulette][:geojson]                                  = "#{node[:valhalla][:tile_dir]}/#{node[:maproulette][:geojson_file]}"

# where to put fresh tiles and who wants them
default[:valhalla][:bucket]                                      = 'YOUR_BUCKET'
default[:valhalla][:bucket_dir]                                  = 'YOUR_DIR'
default[:valhalla][:routing_service_stack]                       = 'YOUR_STACK_ID'
default[:valhalla][:routing_service_layers]                      = 'YOUR_LAYER_IDS'
default[:valhalla][:routing_service_elbs]                        = 'YOUR_ELB_NAMES'
default[:valhalla][:routing_service_recipes]                     = 'valhalla::get_routing_tiles'
default[:valhalla][:min_layers_instances]                        = '1'
default[:valhalla][:health_check_timeout]                        = 300
if node[:opsworks] && node[:opsworks][:layers][:'matrix'] && node[:opsworks][:instance][:layers].include?('matrix')
  default[:valhalla][:health_check][:route_action]                 = 'one_to_many'
  default[:valhalla][:health_check][:route_request]                = '{"locations":[{"lat":40.755713,"lon":-73.984010},{"lat":40.756522,"lon":-73.983978},{"lat":40.757448,"lon":-73.984187}],"costing":"pedestrian"}'
else
  default[:valhalla][:health_check][:route_action]                 = 'route'
  default[:valhalla][:health_check][:route_request]                = '{"locations":[{"lat":40.402918,"lon":-76.535017},{"lat":40.403654,"lon": -76.529846}],"costing":"auto"}'
end

# configuration
default[:valhalla][:config]                                      = "#{node[:valhalla][:conf_dir]}/valhalla.json"
if !node[:opsworks] || (node[:opsworks][:layers][:'data-producer'] && node[:opsworks][:instance][:layers].include?('data-producer'))
  default[:valhalla][:max_cache_size]                            = 1024 * 1024 * 1024
else
  default[:valhalla][:max_cache_size]                            = "#{((node.memory.total.to_f / (node.cpu.total.to_f * 2)) * 0.9).floor * 1024}"
end
if !node[:opsworks]
  default[:valhalla][:actions]                                   = '["locate","route","one_to_many","many_to_one","many_to_many","optimized_route","isochrone"]'
elsif node[:opsworks][:layers][:'matrix'] && node[:opsworks][:instance][:layers].include?('matrix')
  default[:valhalla][:actions]                                   = '["one_to_many","many_to_one","many_to_many","optimized_route","isochrone"]'
else
  default[:valhalla][:actions]                                   = '["locate","route"]'
end
default[:valhalla][:elevation][:actions]                         = '["height"]'
default[:valhalla][:mjolnir][:concurrency]                       = node[:cpu][:total]
default[:valhalla][:httpd][:listen_address]                      = '0.0.0.0'
default[:valhalla][:httpd][:port]                                = 8080

# workers
default[:valhalla][:workers][:count]                             = node[:cpu][:total]
