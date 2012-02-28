Vagrant::Config.run do |config|

  config.vm.box = "ubuntu_natty_64"
  config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/fatbusinessman-boxen/ubuntu_natty_64.box"

  config.vm.network :hostonly, "192.168.245.10"

  config.vm.forward_port 80, 8080
  config.vm.share_folder "parallel-flickr", "/parallel-flickr", "."

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "site.pp"
  end

end
