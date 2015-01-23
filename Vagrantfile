# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'valhalla'
  config.vm.box      = 'ubuntu-12.04'
  config.vm.box_url  = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-12.04-amd64-vbox.box'

  config.vm.provider 'virtualbox' do |v|
    host = RbConfig::CONFIG['host_os']

    def memish(ram, mem_max)
      if ram > mem_max
        mem_max
      else
        ram
      end
    end

    mem_divisor = 2
    mem_min     = 2048
    mem_max     = 8192

    if host =~ /darwin/
      cpu = ENV['VALHALLA_VAGRANT_CPUS'] || `sysctl -n hw.ncpu`.to_i
      ram = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / mem_divisor
      mem = memish(ram, mem_max)
    elsif host =~ /linux/
      cpu = ENV['VALHALLA_VAGRANT_CPUS'] || `nproc`.to_i
      ram = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / mem_divisor
      mem = ENV['VALHALLA_VAGRANT_MB'] || memish(ram, mem_max)
    else
      cpu = ENV['VALHALLA_VAGRANT_CPUS'] || 2
      mem = ENV['VALHALLA_VAGRANT_MB'] || mem_min
    end

    v.cpus   = ENV['VALHALLA_VAGRANT_CPUS'] || cpu
    v.memory = ENV['VALHALLA_VAGRANT_MB'] || mem
  end

  # forward 8002
  config.vm.network :forwarded_port, host: 8002, guest: 8002

  config.vm.network :private_network, ip: '33.33.33.10'
  config.berkshelf.berksfile_path = 'Berksfile'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }
    chef.run_list = [
      'recipe[valhalla::default]'
    ]
  end
end
