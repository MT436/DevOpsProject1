Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    # Update and install Java
    sudo apt update
    sudo apt install -y openjdk-11-jdk

    # Install Jenkins
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y jenkins
  SHELL
end
