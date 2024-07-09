#!/bin/bash

# Check if the database directory already exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists, skipping preparation"
else
    echo "Preparing default user and database"

    #--------------mariadb start--------------#
    service mariadb start    # Start MariaDB
    sleep 5                  # Wait for MariaDB to start

    #--------------mariadb config--------------#
    # Create database if not exists
    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

    # Create user if not exists
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    # Grant privileges to user
    mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

    # # Grant all privileges to root user
    # mariadb -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"

    # Flush privileges to apply changes
    mariadb -e "FLUSH PRIVILEGES;"

    echo "Prepared default user and database"

    #--------------mariadb restart--------------#
    # Shutdown mariadb to restart with new config
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

# Restart mariadb with new config in the background to keep the container running
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'