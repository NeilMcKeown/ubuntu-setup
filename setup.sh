#!/bin/bash
EMAIL=neilsimonmckeown@gmail.com

echo "###################################################################################################"
echo "# Updating and upgrading..."
echo "###################################################################################################"
sudo apt-get update
sudo apt-get upgrade

echo "###################################################################################################"
echo "# Installing zsh..."
echo "###################################################################################################"
sudo apt-get install -y zsh

echo "###################################################################################################"
echo "# Installing oh-my-zsh..."
echo "###################################################################################################"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "###################################################################################################"
echo "# Installing Java..."
echo "###################################################################################################"
sudo apt-get install -y openjdk-8-jdk

echo "###################################################################################################"
echo "# Installing Node..."
echo "###################################################################################################"
cd ~
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

# The script clones the nvm repository to ~/.nvm and adds the source line to your profile (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

echo "###################################################################################################"
echo "# Installing Atom..."
echo "###################################################################################################"
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install -y atom

echo "###################################################################################################"
echo "# Installing Yarn..."
echo "###################################################################################################"
cd ~
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install -y yarn

echo "###################################################################################################"
echo "# Installing Yeoman..."
echo "###################################################################################################"
yarn global add yo

yarn global add generator-jhipster

echo "###################################################################################################"
echo "# Installing Docker..."
echo "###################################################################################################"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates

# Add the new GPG key.
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# If the docker.list file does not exist, create it.
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo "docker.list not found, creating..."
    sudo touch /etc/apt/sources.list.d/docker.list
    sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list
fi

# Update apt
sudo apt-get update

# Purge the old repo if it exists.
sudo apt-get purge lxc-docker

sudo apt-get install -y docker-engine

# Add the user to the docker group.
sudo usermod -aG docker ${USER}

sudo service docker start

sudo docker run hello-world

echo "###################################################################################################"
echo "# Installing Docker-Compose..."
echo "###################################################################################################"
sudo curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Command completion
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-composemkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
fpath=(~/.zsh/completion $fpath)fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -iautoload -Uz compinit && compinit -i

echo "###################################################################################################"
echo "# Installing Chrome..."
echo "###################################################################################################"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

echo "Add the following line to your .zshrc / .bashrc etc."
echo "export PATH="$PATH:yarn global bin:$HOME/.config/yarn/global/node_modules/.bin"
