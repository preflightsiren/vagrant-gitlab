# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.host_name = "gitlab.local"
  config.vm.share_folder "puppet-files", "/tmp/vagrant-puppet/files", "files"
  config.vm.forward_port	80, 8080, :name => "nginx", :auto => true
  config.vm.forward_port	8080, 8081, :name => "unicorn direct", :auto => true
  config.vm.network :hostonly, '192.168.1.10'

  config.vm.customize ["modifyvm", :id, "--memory", 512] if config.vm.memory_size < 512 

  config.vm.provision :puppet do |puppet|
    puppet.module_path    = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "gitlab.pp"
  end

end
