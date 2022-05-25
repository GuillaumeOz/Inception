# Install OS in the container.
FROM		debian:buster

ARG PROJECT_NAME
ARG DOMAIN_NAME

ARG WP_DB_NAME
ARG WP_DB_ADMIN
ARG WP_DB_ADMIN_PASSWORD
ARG WP_DB_HOST

# Update server.
RUN			apt-get -y update

# Updgrade server.
RUN         apt-get -y upgrade

# # install Curl.
RUN         apt-get -y install curl

# # install mariadb-client.
# RUN         apt-get -y install mariadb-client
# RUN			apt-get -y install mariadb-server

# Install PHP and extensions.
RUN         apt-get -y install php7.3-fpm

# Php config
COPY        conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY        conf/yolo.conf /etc/php/7.3/fpm/yolo.conf
# COPY        conf/php.ini /etc/php7/conf.d/custom.ini
RUN         mkdir -p /run/php/

# Users config
# RUN         adduser -D -g 'www' www
RUN         useradd -ms /bin/bash www
RUN         usermod -a -G www www
RUN			mkdir -p /var/www
RUN         chown -R www:www /var/www

# RUN         useradd -ms /bin/bash gozsertt
# RUN         usermod -a -G sudo gozsertt
# RUN         useradd robert
# RUN         usermod -a -G users robert

# Install Wordpress
# RUN			mkdir -p /var/www/wordpress
# RUN			mkdir /srcs/
# WORKDIR		/srcs/
# RUN         curl https://wordpress.org/latest.tar.gz -o latest.tar.gz
# RUN         tar -xzvf latest.tar.gz
# RUN			mv ./wordpress/ /var/www/
# WORKDIR		/
# COPY		./conf/index.html /var/www/
# RUN			rm -rf /srcs/

# Install Worpress-cli
# RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN         mv wp-cli.phar /usr/local/bin/wp
# RUN         chmod +x /usr/local/bin/wp
# RUN         chown -R www:www /usr/local/bin/wp
# RUN         wp --path=/var/www core download --allow-root
# # RUN         cat /var/www/wp-config.php
# RUN         rm -rf /var/www/wp-config.php
# # wp config create --dbname=wordpress --dbuser=gozsertt --dbpass=gozserttpass --dbhost=mariadb:3306 --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
# RUN         wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --dbhost=${WP_DB_HOST} --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
# # RUN         wp --path=/var/www core config --dbhost=${WP_DB_HOST} --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --allow-root
# # wp core install --url=yourwebsite.com --title="Your Blog Title" --admin_name=wordpress_admin --admin_password=4Long&Strong1 --admin_email=you@example.com
# RUN         chmod 644 /var/www/wp-config.php
# RUN         wp --path=/var/www core install --url=${DOMAIN_NAME} --title=${PROJECT_NAME} --admin_name=${WP_DB_ADMIN} --admin_password=${WP_DB_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
# RUN         wp --path=/var/www user create /var/www/ gozsertt gozsertt@42.fr --user_pass=gozserttpass --role="administrator" --allow-root
# RUN         wp --path=/var/www user create /var/www/ robert robert@gmail.com --user_pass=robertpass --role="editor" --allow-root
# RUN         wp --path=/var/www plugin install redis-cache --activate --allow-root
# RUN         wp --path=/var/www plugin update --all --allow-root

# Download and Setup Worpress-cli
RUN             curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN             php wp-cli.phar --info
RUN             chmod +x wp-cli.phar
RUN             mv wp-cli.phar /usr/local/bin/wp

# Install Worpress via Worpress-cli

# COPY            conf/index.php index.php
WORKDIR         /var/www/
RUN             wp core download --allow-root

# # RUN           service mysql start
# RUN           wp core config --dbname=wordpress --dbuser=gozsertt --dbpass=gozserttpass --dbhost=mariadb --dbprefix=wp_ --allow-root
# # RUN           wp --path=/var/www core config --dbhost=${WP_DB_HOST} --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --allow-root
# RUN           wp core install --url="gozsertt.42.fr" --title="Inception" --admin_user="gozsertt" --admin_password="gozserttpass" --admin_email="gozsertt@student.42.fr" --allow-root
# # RUN         wp --path=/var/www core install --url=${DOMAIN_NAME} --title=${PROJECT_NAME} --admin_name=${WP_DB_ADMIN} --admin_password=${WP_DB_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
WORKDIR       /

RUN             mkdir -p /var/log/php7
RUN             touch /var/log/php7/www.access.log

# Install Redis
# RUN         wp --path=/var/www redis enable --allow-root

# Expose the port 9000
EXPOSE      9000
# EXPOSE      9001

ENTRYPOINT /usr/sbin/php-fpm7.3 -F -R
