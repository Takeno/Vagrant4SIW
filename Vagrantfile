# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  #config.vm.network :private_network, ip: "192.168.255.4"
  config.vm.network :forwarded_port, guest: 8080, host: 8080 #tomee
  config.vm.network :forwarded_port, guest: 3000, host: 3000 #rails
  config.vm.network :forwarded_port, guest: 5432, host: 5432 #postgresql
  
  config.ssh.forward_agent = true

  config.vm.synced_folder "./www/", "/var/www", id: "vagrant-root", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "./lib/", "/opt/tomee/lib", id: "vagrant-root", :mount_options => ["dmode=777", "fmode=777"]

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--name", "SIW"]
  end

  config.vm.provision :chef_solo do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "openssl"
      chef.add_recipe "java"
      chef.add_recipe "postgresql"
      chef.add_recipe "postgresql::server"
      chef.add_recipe "rvm"
      chef.add_recipe "rvm::system"
      chef.add_recipe "rvm::vagrant"
      chef.add_recipe "nodejs"
      chef.add_recipe "tomee"

      chef.json = {
        :postgresql => {
            :password => {
                :postgres => "siw"
            },
            :version => "9.1",
            :pg_hba => [{
              :comment => '# External access',
              :type => 'host',
              :db => 'all',
              :user => 'all',
              :addr => '0.0.0.0/0',
              :method => 'trust'
            }],
            :config => {
                :ssl => 'false',
                :listen_addresses => '*'
            }
        },
        :nodejs => {
          :install_method => 'package'
        },
        :tomee => {
          :dir => '/opt/tomee',
          :working_dir => '/var/www/java',
          :src_link => 'http://archive.apache.org/dist/tomee/tomee-1.5.2/apache-tomee-1.5.2-jaxrs.tar.gz'
        }
      }
  end

  config.vm.provision :shell, :inline => "echo 'Installing rails... ' && if [[ ! -f `which rails` ]]; then gem install rails; fi"

end