# Install OS in the container.
FROM		debian:buster

ARG MYSQL_DB_NAME
ARG MYSQL_DB_ADMIN
ARG MYSQL_DB_ADMIN_PASSWORD
ARG	MYSQL_DB_USER_PASSWORD
ARG MYSQL_DB_USER
ARG MYSQL_DB_PASSWORD

# Update server.
RUN			apt-get -y update

# Install MariaDB.
RUN			apt-get -y install mariadb-server

# Paste configuration files 
COPY		conf/my.cnf /etc/mysql/

# Initialize mariadb
RUN			mysql_install_db --datadir=/var/lib/mysql --user=mysql

# Starts and configure mysql.
RUN		service mysql start	&& \
		echo "CREATE DATABASE $MYSQL_DB_NAME;" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'localhost';" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "CREATE USER '$MYSQL_DB_USER'@'localhost';" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "SET password FOR '$MYSQL_DB_ADMIN'@'localhost' = password('$MYSQL_DB_ADMIN_PASSWORD');" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "SET password FOR '$MYSQL_DB_USER'@'localhost' = password('$MYSQL_DB_USER_PASSWORD');" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_ADMIN'@'localhost' WITH GRANT OPTION;" | mysql -u root --socket=/var/run/mysqld/mysqld.sock && \
		echo "FLUSH PRIVILEGES;" | mysql -u root --socket=/var/run/mysqld/mysqld.sock 
		# mysql $MYSQL_DB_NAME -u root < /var/www/wordpress/$MYSQL_DB_NAME.sql

# Restart mysql service
RUN service mysql stop \
    && service mysql start

# Expose the port 3306
EXPOSE		3306

CMD ["mysqld"]