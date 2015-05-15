# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Recipe:: serve
#

include_recipe 'runit::default'

# httpd
runit_service 'prime-httpd' do
  action          :enable
  log             true
  default_logger  true
  sv_timeout      60
  retries         3
  env(
    'LD_LIBRARY_PATH' => '/usr/lib:/usr/local/lib'
  )
end

# cake layers
%w(loki thor odin tyr).each do |layer|
  # proxy
  runit_service "proxyd-#{layer}" do
    action            :enable
    log               true
    default_logger    true
    run_template_name 'proxyd-global-run'
    sv_timeout        60
    retries           3
    options(layer: layer)
    env('LD_LIBRARY_PATH' => '/usr/lib:/usr/local/lib')
  end

  # workers
  (0..7).step(1).each do |num|
    runit_service "workerd-#{layer}-#{num}" do
      action            :enable
      log               true
      default_logger    true
      run_template_name 'workerd-global-run'
      sv_timeout        60
      retries           3
      options(layer: layer, num: num)
      env('LD_LIBRARY_PATH' => '/usr/lib:/usr/local/lib')
    end
  end
end
