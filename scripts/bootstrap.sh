#!/bin/sh

helloworld_func(){
	echo "Hello World!!!"
}

puppet_func(){
	wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
	sudo dpkg -i puppetlabs-release-trusty.deb -y
	sudo apt-get update -y
	sudo apt-get install puppet-common -y
}

helloworld_func
#java8_func
#java6_func
#sublime3_func
puppet_func
#nodejs_dep_func
#mongodb_func
#chromium_func


