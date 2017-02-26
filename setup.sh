#!/bin/bash
EMAIL=neilsimonmckeown@gmail.com

###################################################################################################
# Update and Upgrade
###################################################################################################
echo "Updating..."
sudo apt-get update
echo "Upgrading..."
sudo apt-get upgrade

###################################################################################################
# Install git
###################################################################################################
echo "Installing git"
sudo apt-get install -y git

###################################################################################################
# Install zsh
###################################################################################################
echo "Installing zsh..."
sudo apt-get install -y zsh

###################################################################################################
# Install oh-my-zsh
###################################################################################################
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

###################################################################################################
# Install Java
###################################################################################################
echo "Installing Java..."
sudo apt-get install -y openjdk-8-jdk

###################################################################################################
# Install Node
###################################################################################################
cd ~
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

# The script clones the nvm repository to ~/.nvm and adds the source line to your profile (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

###################################################################################################
# Install Atom
###################################################################################################
echo "Installing Atom..."
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install -y atom

###################################################################################################
# Yarn
###################################################################################################
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install -y yarn

###################################################################################################
# Yeoman
###################################################################################################
yarn global add yo

yarn global add generator-jhipster

###################################################################################################
# Docker
###################################################################################################
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

sudo service docker start

sudo docker run hello-world

###################################################################################################
# Install Docker-Compose
##################################################################################################
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit

# Command completion
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-composemkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
fpath=(~/.zsh/completion $fpath)fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -iautoload -Uz compinit && compinit -i

###################################################################################################
# Install Chrome
###################################################################################################
echo "Installing Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

###################################################################################################
# Install Intellij
###################################################################################################
echo "Installing IntelliJ IDEA..."

# We need root to install
#[ $(id -u) != "0" ] && exec sudo "$0" "$@"

# Prompt for edition
while true; do
    read -p "Enter 'U' for Ultimate or 'C' for Community: " ed
    case $ed in
        [Uu]* ) ed=U; break;;
        [Cc]* ) ed=C; break;;
    esac
done

# Fetch the most recent version
VERSION=$(wget "https://www.jetbrains.com/intellij-repository/releases" -qO- | grep -P -o -m 1 "(?<=https://www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/idea/BUILD/)[^/]+(?=/)")

# Prepend base URL for download
URL="https://download.jetbrains.com/idea/ideaI$ed-$VERSION.tar.gz"

echo $URL

# Truncate filename
FILE=$(basename ${URL})

# Set download directory
DEST=~/Downloads/$FILE

echo "Downloading idea-I$ed-$VERSION to $DEST..."

# Download binary
wget -cO ${DEST} ${URL} --read-timeout=5 --tries=0

echo "Download complete!"

# Set directory name
DIR="/opt/idea-I$ed-$VERSION"

echo "Installing to $DIR"

# Untar file
if sudo mkdir ${DIR}; then
    sudo tar -xzf ${DEST} -C ${DIR} --strip-components=1
fi

# Grab executable folder
BIN="$DIR/bin"

# Add permissions to install directory
sudo chmod -R +rwx ${DIR}

# Create symlink entry
sudo ln -sf ${BIN}/idea.sh /usr/local/bin/idea

echo "Done."
whoami
