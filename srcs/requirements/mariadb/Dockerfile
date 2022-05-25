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
		echo "CREATE DATABASE $MYSQL_DB_NAME;" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_ADMIN'@'*' = password('$MYSQL_DB_ADMIN_PASSWORD');" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_USER'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_USER'@'*' = password('$MYSQL_DB_USER_PASSWORD');" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_ADMIN'@'*' WITH GRANT OPTION;" | mysql -u root && \
		echo "GRANT ALL ON '$MYSQL_DB_NAME'.* to '$MYSQL_DB_ADMIN'@'*' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" && \
		echo "SELECT host FROM mysql.user WHERE user = '$MYSQL_DB_ADMIN';"  | mysql -u root  && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'%' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_DB_ADMIN'@'%';" | mysql -u root && \
		echo "FLUSH PRIVILEGES;" | mysql -u root
		# > /bootstrap.sql
		# mysql $MYSQL_DB_NAME -u root < /var/www/wordpress/$MYSQL_DB_NAME.sql


# mysql --host=mariadb --user gozsertt -pgozserttpass

# Restart mysql service
# RUN service mysql stop \
#     && service mysql start

# Expose the port 3306
EXPOSE		3306

CMD ["mysqld"]