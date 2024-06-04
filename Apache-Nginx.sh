#!/bin/bash

# Function to install Apache
install_apache() {
    echo "Installing Apache..."
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl enable apache2
    sudo systemctl start apache2
    echo "Apache installed and started."
}

# Function to install Nginx
install_nginx() {
    echo "Installing Nginx..."
    sudo apt update
    sudo apt install -y nginx nginx-extras nginx-module-xslt
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "Nginx installed and started."
}

# Function to stop Apache
stop_apache() {
    echo "Stopping Apache..."
    sudo systemctl stop apache2
    sudo systemctl disable apache2
    echo "Apache stopped."
}

# Function to stop Nginx
stop_nginx() {
    echo "Stopping Nginx..."
    sudo systemctl stop nginx
    sudo systemctl disable nginx
    echo "Nginx stopped."
}

# Install Apache and Nginx
install_apache
install_nginx

# Ask user which service to keep running
while true; do
    read -p "Which service do you want to keep running? (apache/nginx): " service
    case $service in
        apache )
            stop_nginx
            echo "Apache is running."
            break;;
        nginx )
            stop_apache
            echo "Nginx is running."
            break;;
        * )
            echo "Please answer apache or nginx.";;
    esac
done

echo "Setup completed."
