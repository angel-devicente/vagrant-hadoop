# -*- mode: ruby -*-
# vi: set ft=ruby :

##############################################
### WARNING: ONLY FOR TESTING!!!!!!
##############################################

# Hadoop Cluster. Minimum number or nodes = 3 (if more required, just modify numNodes below)
#
# node1         : HDFS NameNode + Spark Master
# node2         : YARN ResourceManager + JobHistoryServer + ProxyServer
# [node3:nodeX] : HDFS DataNode + YARN NodeManager + Spark Slave
#


Vagrant.require_version ">= 1.4.3"
Vagrant.configure("2") do |config|
	numNodes = 5
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "node#{i}" do |node|

			node.vm.box = "hashicorp/bionic64"

			node.vm.provider "virtualbox" do |v|
			  v.name = "node#{i}"
			  v.customize ["modifyvm", :id, "--memory", "2048"]
			end

			if i < 10
				node.vm.network :private_network, ip: "10.211.55.10#{i}"
			else
				node.vm.network :private_network, ip: "10.211.55.1#{i}"
			end
			node.vm.hostname = "node#{i}"

			node.vm.provision "shell", path: "scripts/setup-bionic.sh"
			node.vm.provision "shell" do |s|
			  s.path = "scripts/setup-bionic-hosts.sh"
			  s.args = "-t #{numNodes}"
                        end


                        # Setup SSH acces 
                        #################
                        # # from node 2 to all the others
                        if i == 2
			  node.vm.provision "shell" do |s|
			    s.path = "scripts/setup-bionic-ssh.sh"
			    s.args = "-s 3 -t #{numNodes}"
			  end
			end
                        
                        # from node 1 to all the others
			if i == 1
			  node.vm.provision "shell" do |s|
			    s.path = "scripts/setup-bionic-ssh.sh"
			    s.args = "-s 2 -t #{numNodes}"
			  end
			end

			# Setting up mysql server
			if i == 2
			  node.vm.provision "shell" do |s|
			    s.path = "scripts/setup-mysql.sh"
			  end
			end
                                                
                        # Setup Hadoop (Hadoop workers [3:X])
			node.vm.provision "shell", path: "scripts/setup-hadoop.sh"
			node.vm.provision "shell" do |s|
			 	s.path = "scripts/setup-hadoop-workers.sh"
			 	s.args = "-s 3 -t #{numNodes}"
			 end

			# Setting up Java
			node.vm.provision "shell", path: "scripts/setup-java.sh"
                        if i == 1
                          node.vm.provision "shell" do |s|
                            s.path = "scripts/setup-javac.sh"
                          end
                        end
                        
			# Setup spark  (Spark slaves [3:X])
			node.vm.provision "shell", path: "scripts/setup-spark.sh"
			node.vm.provision "shell" do |s|
			  s.path = "scripts/setup-spark-slaves.sh"
			  s.args = "-s 3 -t #{numNodes}"
			end

                        ### why only on datanodes? My idea is to interact always from node1, so I think I should better install it everywhere
			# Setup pig & hive client in datanodes
#			if i > 1
			node.vm.provision "shell" do |s|
			  s.path = "scripts/setup-hive.sh"
#			  end
			end
                        
#			if i > 1
			node.vm.provision "shell" do |s|
			  s.path = "scripts/setup-pig.sh"
#			  end
			end

                        # Setup NameNode in node 1
			if i == 1
			  node.vm.provision "shell" do |s|
			    s.path = "scripts/setup-namenode.sh"
			  end
			end

                end
	end
end
