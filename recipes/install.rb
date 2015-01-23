# -*- coding: UTF-8 -*-
#
# Cookbook Name:: valhalla
# Recipe:: install
#

# for each repository
default[:valhalla][:github][:repos].each do |repo|

  # clone it
  git "clone #{repo}" do
    action :sync
    user node[:valhalla][:user][:name]
    repo node[:valhalla][:github][:base] + repo + '.git'
    revision node[:valhalla][:github][:revision]
    enable_submodules true
    depth 1
    notifies :run, "execute[configure #{repo}]", :immediately
    notifies :run, "execute[install #{repo}]", :immediately
  end

  # configure
  execute "configure #{repo}" do
    action :nothing
    command './autogen.sh && ./configure CPPFLAGS="-DLOGGING_LEVEL_INFO" --with-valhalla-midgard=/usr/local --with-valhalla-baldr=/usr/local --with-valhalla-mjolnir=/usr/local --with-valhalla-loki=/usr/local --with-valhalla-odin=/usr/local --with-valhalla-thor=/usr/local --with-valhalla-tyr=/usr/local'
    cwd "#{node[:valhalla][:basedir]}/#{repo}/current"
  end

  # install
  execute "install #{repo}" do
    action :nothing
    command "make -j#{node[:cpu][:total]} install"
    cwd "#{node[:valhalla][:basedir]}/#{repo}/current"
  end

end

# fetch the submodules
# execute 'submodules' do
#  action :nothing
#  command 'git submodule update --init --recursive'
#  cwd "#{node[:valhalla][:basedir]}/tyr/current"
# end
