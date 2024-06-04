#!/bin/bash

# Script to install or uninstall Node.js using NVM on Ubuntu

# Disable automatic reboot notification
export DEBIAN_FRONTEND=noninteractive

# Pre-configure debconf to avoid interactive kernel upgrade notifications
echo 'linux-base linux-base/removable_mount_options_changed boolean true' | sudo debconf-set-selections


# Function to install NVM
install_nvm() {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
}

# Check if NVM is installed
if ! command -v nvm &> /dev/null
then
    install_nvm
else
    echo "NVM is already installed."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Ask user for the action to perform
while true; do
    read -p "Do you want to install (y) or uninstall (n) Node.js? (y/n): " action
    case $action in
        [Yy]* ) action="install"; break;;
        [Nn]* ) action="uninstall"; break;;
        * ) echo "Please answer y or n.";;
    esac
done

# Ask user for the Node.js version
read -p "Enter the Node.js version (e.g., 14.17.0): " node_version

if [ "$action" == "install" ]; then
    # Install Node.js using NVM
    nvm install $node_version
    nvm use $node_version
    echo "Node.js version $node_version has been installed."
elif [ "$action" == "uninstall" ]; then
    # Uninstall Node.js using NVM
    nvm uninstall $node_version
    echo "Node.js version $node_version has been uninstalled."
fi

echo "Please run 'source ~/.bashrc' to apply changes to your current session."
source ~/.bashrc
