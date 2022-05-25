# Install OS in the container.
FROM		debian:buster

# Update server.
RUN			apt-get -y update

# Install Nginx.
RUN			apt-get -y install nginx

# Install Nginx.
RUN			apt-get -y install openssl

# Create www user and group
RUN			useradd www
RUN			usermod -a -G www www
RUN			chown -R www:www /var/lib/nginx
RUN			chown -R www:www /var/www
RUN			mkdir /run/nginx/

# Create SSL dir and Makes a SSL certification with openssl.
RUN 		mkdir /etc/nginx/ssl/ && cd /etc/nginx/ssl/ \
			&& openssl req -x509 \
			-out gozsertt.crt \
			-keyout gozsertt.key \
			-newkey rsa:2048 -nodes -sha256 \
			-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=gozsertt/CN=gozsertt/distinguished_name=dn/subjectAltName=DNS:gozsertt.42.fr/keyUsage=digitalSignature/extendedKeyUsage=serverAuth" \
			&& chmod 600 gozsertt.crt \
			&& chmod 600 gozsertt.key

# Copy nginx.conf in Nginx's directory.
COPY		/conf/nginx.conf	/etc/nginx/nginx.conf

# Expose the port 443
EXPOSE 443

# daemon off run in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
