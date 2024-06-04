#!/bin/bash

# Variables for MySQL root password and other configurations
MYSQL_ROOT_PASSWORD="Shivam@123"
MYSQL_ROOT_HOST="localhost"
MYSQL_DEFAULT_DATABASE="firstdb"
MYSQL_USER="shivam"
MYSQL_USER_PASSWORD="Shivam@123"
MYSQL_SECURE_INSTALLATION_SCRIPT="mysql_secure_installation.sql"

# Disable automatic reboot notification
export DEBIAN_FRONTEND=noninteractive

# Pre-configure debconf to avoid interactive kernel upgrade notifications
echo 'linux-base linux-base/removable_mount_options_changed boolean true' | sudo debconf-set-selections

# Create the missing MySQL configuration directory and file
sudo mkdir -p /etc/mysql
sudo touch /etc/mysql/mysql.cnf

# Install MySQL Server and Client
sudo apt-get update
sudo apt-get install -y mysql-server mysql-client

# Create a temporary MySQL secure installation script
cat <<EOF >$MYSQL_SECURE_INSTALLATION_SCRIPT
-- Perform secure installation
-- Remove anonymous users
-- Disallow root login remotely
-- Remove test database and access to it
-- Reload privilege tables now

DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
ALTER USER 'root'@'$MYSQL_ROOT_HOST' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('$MYSQL_ROOT_HOST', 'localhost');
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

# Run secure installation script
sudo mysql -u root < $MYSQL_SECURE_INSTALLATION_SCRIPT

# Clean up
rm $MYSQL_SECURE_INSTALLATION_SCRIPT

# Create MySQL user and grant privileges
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $MYSQL_DEFAULT_DATABASE;
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DEFAULT_DATABASE.* TO '$MYSQL_USER'@'localhost';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT

echo "MySQL installation and secure configuration completed successfully!"
