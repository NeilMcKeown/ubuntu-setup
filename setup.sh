#!/bin/bash
EMAIL=neilsimonmckeown@gmail.com

echo "###################################################################################################"
echo "# Updating and upgrading..."
echo "###################################################################################################"
sudo apt-get update
sudo apt-get upgrade

echo "###################################################################################################"
echo "# Installing curl..."
echo "###################################################################################################"
sudo apt install -y curl

echo "###################################################################################################"
echo "# Installing git..."
echo "###################################################################################################"
sudo apt install -y git

echo "###################################################################################################"
echo "# Installing zsh..."
echo "###################################################################################################"
sudo apt install -y zsh

echo "###################################################################################################"
echo "# Increasing inotify watches..."
echo "###################################################################################################"
sudo sed -i -e '$a\
fs.inotify.max_user_watches = 524288' /etc/sysctl.conf

sudo sysctl -p --system

echo "###################################################################################################"
echo "# Installing Java..."
echo "###################################################################################################"
sudo apt install -y openjdk-8-jdk

echo "###################################################################################################"
echo "# Installing Atom..."
echo "###################################################################################################"
snap install atom --classic

echo "###################################################################################################"
echo "# Installing Node.js & npm..."
echo "###################################################################################################"
cd ~
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
nvm install node
nvm use node
# The script clones the nvm repository to ~/.nvm and adds the source line to your profile (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

echo "###################################################################################################"
echo "# Installing Yarn..."
echo "###################################################################################################"
sudo apt remove cmdtest
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn

echo "###################################################################################################"
echo "# Installing Yeoman..."
echo "###################################################################################################"
yarn global add yo

echo "###################################################################################################"
echo "# Installing JHipster..."
echo "###################################################################################################"
yarn global add generator-jhipster

echo "###################################################################################################"
echo "# Installing Cloud Foundry CLI..."
echo "###################################################################################################"
# ...first add the Cloud Foundry Foundation public key and package repository to your system
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

# ...then, update your local package index, then finally install the cf CLI
sudo apt update
sudo apt install -y cf-cli

echo "###################################################################################################"
echo "# Installing Docker..."
echo "###################################################################################################"
#sudo apt-get update
#sudo apt-get install -y apt-transport-https ca-certificates

# Add the new GPG key.
#sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# If the docker.list file does not exist, create it.
#if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
#    echo "docker.list not found, creating..."
#    sudo touch /etc/apt/sources.list.d/docker.list
#    sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list
#fi

# Update apt
#sudo apt-get update

# Purge the old repo if it exists.
#sudo apt-get purge lxc-docker

#sudo apt-get install -y docker-engine

# Add the user to the docker group.
#sudo usermod -aG docker ${USER}

#sudo service docker start

#sudo docker run hello-world

echo "###################################################################################################"
echo "# Installing Docker-Compose..."
echo "###################################################################################################"
#sudo curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

# Command completion
#mkdir -p ~/.zsh/completion
#curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-composemkdir -p ~/.zsh/completion
#curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
#fpath=(~/.zsh/completion $fpath)fpath=(~/.zsh/completion $fpath)
#autoload -Uz compinit && compinit -iautoload -Uz compinit && compinit -i

echo "###################################################################################################"
echo "# Installing Chrome..."
echo "###################################################################################################"
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#sudo apt-get -f install

#echo "Add the following line to your .zshrc / .bashrc etc."
#echo 'export PATH="$PATH:yarn global bin:$HOME/.config/yarn/global/node_modules/.bin'

echo "###################################################################################################"
echo "# Installing Spotify..."
echo "###################################################################################################"

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt update

# 4. Install Spotify
sudo apt install -y spotify-client

echo "###################################################################################################"
echo "# Installing SSH keys..."
echo "###################################################################################################"

ssh-keygen -t rsa -b 4096 -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Downloads and installs xclip. If you don't have `apt-get`, you might need to use another installer (like `yum`)
sudo apt install -y xclip

# Copies the contents of the id_rsa.pub file to your clipboard
xclip -sel clip < ~/.ssh/id_rsa.pub

### Do this last. ###
echo "###################################################################################################"
echo "# Installing oh-my-zsh..."
echo "###################################################################################################"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
