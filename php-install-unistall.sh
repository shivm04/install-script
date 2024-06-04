#!/bin/bash

# List of PHP 8.0 modules
modules=(
    php8.0
    php8.0-bcmath
    php8.0-bz2
    php8.0-calendar
    php8.0-ctype
    php8.0-curl
    php8.0-date
    php8.0-dom
    php8.0-exif
    php8.0-fileinfo
    php8.0-filter
    php8.0-ftp
    php8.0-gd
    php8.0-gettext
    php8.0-iconv
    php8.0-igbinary
    php8.0-json
    php8.0-mbstring
    php8.0-mcrypt
    php8.0-memcache
    php8.0-memcached
    php8.0-mongodb
    php8.0-msgpack
    php8.0-mysqli
    php8.0-mysqlnd
    php8.0-openssl
    php8.0-pcntl
    php8.0-pdo
    php8.0-pdo_mysql
    php8.0-pdo_sqlite
    php8.0-phar
    php8.0-posix
    php8.0-readline
    php8.0-redis
    php8.0-reflection
    php8.0-session
    php8.0-shmop
    php8.0-simplexml
    php8.0-soap
    php8.0-sockets
    php8.0-spl
    php8.0-sqlite3
    php8.0-standard
    php8.0-sysvmsg
    php8.0-sysvsem
    php8.0-sysvshm
    php8.0-tokenizer
    php8.0-xml
    php8.0-xmlreader
    php8.0-xmlrpc
    php8.0-xmlwriter
    php8.0-xsl
    php8.0-opcache
    php8.0-zip
    php8.0-zlib
)

# Function to prompt user for installation or uninstallation
prompt_user() {
    while true; do
        read -p "Do you want to $1 PHP 8.0 and its modules? (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Add Ondrej PHP PPA repository
sudo add-apt-repository ppa:ondrej/php -y

# Set DEBIAN_FRONTEND to noninteractive to avoid any interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Pre-configure debconf to avoid interactive kernel upgrade notifications
echo 'linux-base linux-base/removable_mount_options_changed boolean true' | sudo debconf-set-selections


# Update package list
sudo apt update

if prompt_user "install"; then
    for module in "${modules[@]}"; do
        sudo apt install -y $module
    done
elif prompt_user "uninstall"; then
    for module in "${modules[@]}"; do
        sudo apt remove -y $module
    done
else
    echo "No action taken."
fi

# Cleanup
sudo apt autoremove -y
sudo apt clean

echo "Script execution completed."
