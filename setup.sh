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
sudo apt-get install git

###################################################################################################
# Install zsh
###################################################################################################
echo "Installing zsh..."
sudo apt-get install zsh

###################################################################################################
# Install oh-my-zsh
###################################################################################################
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

###################################################################################################
# Install Java
###################################################################################################
echo "Installing Java..."
sudo apt-get install openjdk-8-jdk

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
sudo apt-get install atom

###################################################################################################
# Yarn
###################################################################################################
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn

###################################################################################################
# Yeoman
###################################################################################################
yarn global add yo

yarn global add generator-jhipster

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
