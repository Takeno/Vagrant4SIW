Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  #config.vm.network :private_network, ip: "192.168.255.4"
  config.vm.network :forwarded_port, guest: 8080, host: 8080 #tomee
  config.vm.network :forwarded_port, guest: 3000, host: 3001 #rails
  config.vm.network :forwarded_port, guest: 5432, host: 5432 #postgresql
  
  config.ssh.forward_agent = true

  #config.vm.synced_folder "./www/", "/var/www", id: "vagrant-root", :mount_options => ["dmode=777", "fmode=777"]
  config.vm.synced_folder "./lib/", "/opt/tomee/lib", id: "vagrant-root", :mount_options => ["dmode=777", "fmode=777"]

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 512] # RAM
    v.customize ["modifyvm", :id, "--name", "SIW"]
  end

  config.vm.provision :chef_solo do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "openssl"
      chef.add_recipe "java::default"
      chef.add_recipe "postgresql"
      chef.add_recipe "postgresql::server"
      chef.add_recipe "tomee"


      chef.json = {
        :java => {
          :jdk_version => '7'
        },
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
        :tomee => {
          :dir => '/opt/tomee',
          :working_dir => '/vagrant/www/java',
          :src_link => 'http://archive.apache.org/dist/tomee/tomee-1.7.1/apache-tomee-1.7.1-jaxrs.tar.gz'
        }
      }
  end

  # Installing ruby2.2
  # config.vm.provision :shell, :inline => "echo 'Installing ruby 2.2... ' && su - vagrant rvm install 2.2.1"
  # config.vm.provision :shell, :inline => "su - vagrant 'rvm --default use 2.2.1'"
  # # Installing rails
  # config.vm.provision :shell, :inline => "echo 'Installing rails... ' && if [[ ! -f `which rails` ]]; then gem install rails; fi"
  config.vm.provision :shell, :path => "./install-ruby.sh"
end
