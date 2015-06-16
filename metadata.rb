# -*- coding: UTF-8 -*-

name             'valhalla'
maintainer       'valhalla'
maintainer_email 'valhalla@mapzen.com'
license          'MIT'
description      'Installs/Configures valhalla'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.4'

recipe 'valhalla', 'Installs valhalla'

%w(
  apt
  user
  runit
).each do |dep|
  depends dep
end

supports 'ubuntu', '>= 12.04'
