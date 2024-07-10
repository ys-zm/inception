#!/bin/sh

# Check if wp-config.php exists in the current directory
if [ -f ./wp-config.php ]; then
    echo "WordPress already downloaded"
else
    # Download WordPress core files to /var/www/html directory
    wp core download --path="/var/www/html" --allow-root
fi

# Check if wp-config.php exists in the /var/www/html directory
if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress is already configured"
else
    echo "Creating WordPress config..."

    # Change directory to /var/www/html
    cd /var/www/html

    # Create WordPress configuration file wp-config.php
    wp config create --path="/var/www/html" \
                     --dbname="$MYSQL_DATABASE" \
                     --dbuser="$MYSQL_USER" \
                     --dbpass="$MYSQL_PASSWORD" \
                     --dbhost="mariadb" \
                     --allow-root

    echo "Installing WordPress core..."

    # Install WordPress with specified configuration
    wp core install --path="/var/www/html" \
                    --title="wordpress" \
                    --admin_user="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="yzaim@codam.student.nl" \
                    --url="https://yzaim.codam.nl/" \
                    --skip-email \
                    --allow-root

    echo "Creating an additional user..."

    # Create an additional user for WordPress
    wp user create "$WP_USER" user@user.com \
                    --path="/var/www/html" \
                    --user_pass="$WP_USER_PASSWORD" \
                    --allow-root
fi

# Start php-fpm
echo "Running php-fpm."
exec "$@"

