#!/bin/sh

#check if wp-config.php exist
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
	wp core download --path="/var/www/html" --allow-root
fi

if [ -f /var/www/html/wp-config.php ]; then
    echo "WordPress is already configured"
else
    echo "Creating Wordpress config..."

    cd /var/www/html

    wp config create --path="/var/www/html" \
                     --dbname="$MYSQL_DATABASE" \
                     --dbuser="$MYSQL_USER" \
                     --dbpass="$MYSQL_PASSWORD" \
                     --dbhost="mariadb" \
                     --allow-root

    echo "Installing Wordpress core..."

    wp core install --path="/var/www/html" \
                    --title="wordpress" \
                    --admin_user="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="casper@cschuijt.nl" \
                    --url="https://cschuijt.42.fr/" \
                    --skip-email \
                    --allow-root


    echo "Creating an additional user..."

    wp user create "$WP_USER" user@user.com \
                    --path="/var/www/html" \
                    --user_pass="$WP_USER_PASSWORD" \
                    --allow-root
fi

echo "Running php-fpm."
exec "$@"

