#!/bin/bash

# Disable interactive prompts during uninstallation
export DEBIAN_FRONTEND=noninteractive

# Pre-configure debconf to avoid interactive kernel upgrade notifications
echo 'linux-base linux-base/removable_mount_options_changed boolean true' | sudo debconf-set-selections

# Uninstall MySQL Server and Client
sudo apt-get remove mysql-server mysql-client -y
sudo apt-get purge -y mysql-server mysql-client -y

# Remove configuration files
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql

# Remove any remaining MySQL packages
sudo apt-get autoremove -y

echo "MySQL Server and Client have been successfully uninstalled."
