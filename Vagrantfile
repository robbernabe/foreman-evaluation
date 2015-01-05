# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

unless Vagrant.has_plugin?("vagrant-hostmanager")
  raise Vagrant::Errors::VagrantError.new, "Missing required plugin. Please run 'vagrant plugin install vagrant-hostmanager'"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/precise64"

  # Mange /etc/hosts in the VMs and on the local machine
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.define "foreman" do |foreman|
    foreman.vm.hostname = "foreman.local"
    foreman.hostmanager.aliases = %w(foreman)
    foreman.vm.provision "shell", path: "foreman-installer.sh"
    foreman.vm.provision "shell", path: "configure-puppet.sh"
    foreman.vm.network "private_network", ip: "192.168.232.100"
    foreman.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define "agent1" do |agent1|
    agent1.vm.hostname = "agent1.local"
    agent1.hostmanager.aliases = %w(agent1)
    agent1.vm.network "private_network", ip: "192.168.232.101"
    agent1.vm.provision "shell", path: "install-puppet.sh"
    agent1.vm.provision "shell", path: "configure-puppet.sh"
  end
end
