# Install OS in the container.
FROM		debian:buster

ARG PROJECT_NAME
ARG DOMAIN_NAME
ARG WP_DB_NAME
ARG WP_DB_ADMIN
ARG WP_DB_ADMIN_PASSWORD
ARG WP_DB_ADMIN_EMAIL
ARG WP_DB_HOST
ARG MYSQL_DB_USER
ARG MYSQL_DB_USER_PASSWORD
ARG MYSQL_DB_USER_EMAIL

# Update server.
RUN			apt-get -y update

# Updgrade server.
RUN         apt-get -y upgrade

# install Curl.
RUN         apt-get -y install curl

# install mariadb-client.
RUN         apt-get -y install mariadb-client

# Install PHP and extensions.
RUN         apt-get -y install php7.3-fpm php7.3-mysqli

# Php config
COPY        conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY        conf/yolo.conf /etc/php/7.3/fpm/yolo.conf
RUN         mkdir -p /run/php/

# Users config
RUN         useradd -ms /bin/bash www
RUN         usermod -a -G www www
RUN			mkdir -p /var/www
RUN         chown -R www:www /var/www

# Users config
RUN         useradd -ms /bin/bash gozsertt
RUN         usermod -a -G sudo gozsertt
RUN         useradd robert
RUN         usermod -a -G users robert

#Download and Setup Worpress-cli
RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN         php wp-cli.phar --info
RUN         chmod +x wp-cli.phar
RUN         mv wp-cli.phar /usr/local/bin/wp
RUN         chown -R www:www /usr/local/bin/wp

# Install Worpress via Worpress-cli
WORKDIR     /var/www/
RUN         rm -rf /var/www/wp-config.php
RUN         wp core download --allow-root
RUN         wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --dbhost=mariadb --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
WORKDIR     /

# Move tools
COPY        /tools/ /tools/
RUN         chmod +x /tools/entrypoint.sh 

EXPOSE      9000
