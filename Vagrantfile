# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$number_of_slaves = (ENV['MESOS_SLAVES'] || 1).to_i

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    # config.cache.synced_folder_opts = {
    #   type: :nfs,
    #   mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    # }
  end

  # masters = ['ninja', 'nova', 'nuclear']
  masters = ['ninja']
  #slaves = ['tornado', 'torpedo', 'trident']
  slaves = ['tornado']
  all = masters + slaves[0, $number_of_slaves]

  all.each_with_index do |name, i|
    config.vm.define name do |instance|
      instance.vm.hostname = name
      
      # Virtualbox provider:
      instance.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", "1024"]
        #  # Customize the amount of cpu cores to be specified for this VM
        vb.customize ["modifyvm", :id, "--cpus", "4"]   
      end


      instance.vm.box = "ubuntu/trusty64"
      instance.vm.provision :shell, :path => 'scripts/puppet.sh'

      instance.vm.network "private_network", :ip => "10.24.1.1#{i+1}"
       # for mesos web UI.
       instance.vm.network :forwarded_port, guest: 5050, host: 5050
       # for Marathon web UI
       instance.vm.network :forwarded_port, guest: 8080, host: 8080
        # for Chronos web UI
       instance.vm.network :forwarded_port, guest: 8081, host: 8081




      instance.vm.provision :puppet do |puppet|
        #puppet.options        = '--debug --verbose --summarize --reports store --hiera_config=/vagrant/hiera.yaml'
        puppet_log =  "/vagrant/puppet_logs_#{name}.txt"
        puppet.options        = "--debug --verbose --summarize --logdest #{puppet_log} --trace"
        puppet.hiera_config_path = "hiera.yaml"

        puppet.environment_path = "puppet_manifests"
        puppet.environment = "manifests"

        puppet.manifests_path = "puppet_manifests/manifests"
        puppet.module_path    = [ 'modules', 'vendor/modules' ]
        puppet.manifest_file  = 'base.pp'
      end
    end
  end

end
