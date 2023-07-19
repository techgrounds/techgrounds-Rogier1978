#!/bin/bash
    sudo su
    apt update
    apt install apache2 -y
    ufw allow 'Apache'
    systemctl enable apache2
    systemctl restart apache2
    sudo apt install mysql-client-core-8.0
    sudo apt-get install mysql-server