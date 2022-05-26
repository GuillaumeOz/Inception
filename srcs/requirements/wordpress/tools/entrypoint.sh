#!/bin/sh

wp core install --path=/var/www --url=$DOMAIN_NAME --title=$PROJECT_NAME --admin_name=$WP_DB_ADMIN --admin_password=$WP_DB_ADMIN_PASSWORD --admin_email=$WP_DB_ADMIN_EMAIL --allow-root --skip-email
/usr/sbin/php-fpm7.3 -F -R