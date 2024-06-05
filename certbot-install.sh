#!/bin/bash

# Update package index
sudo apt-get update

# Install Certbot
sudo apt-get install -y certbot

# Install the Certbot Apache plugin (if you're using Apache)
sudo apt-get install -y python3-certbot-apache

# Install the Certbot Nginx plugin (if you're using Nginx)
sudo apt-get install -y python3-certbot-nginx

# Display installation status
certbot --version

echo "Certbot has been installed successfully"
