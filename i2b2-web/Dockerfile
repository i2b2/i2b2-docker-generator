
FROM ubuntu:oracular-20241009
ENV DEBIAN_FRONTEND=noninteractive
 
RUN apt-get update && \
    apt-get install -y apache2 openssl php libapache2-mod-php php-curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
 
EXPOSE 80 443
ADD run-httpd.sh /run-httpd.sh
RUN chmod +x /run-httpd.sh 
 
Copy ./i2b2_proxy.conf /etc/apache2/sites-available/

RUN cat /etc/apache2/sites-available/i2b2_proxy.conf |sed -e s/9090/8080/ >  /etc/apache2/sites-available/i2b2_proxy.conf
RUN cat /etc/apache2/sites-available/i2b2_proxy.conf |sed -e s/9090/8080/ >  /etc/apache2/sites-available/ssl.conf
 
# Enable the proxy configuration
RUN a2ensite i2b2_proxy.conf && a2enmod ssl proxy proxy_http
 
ADD ./i2b2-webclient /var/www/html/webclient/

# ADD ./i2b2-webclient /var/www/html/admin/

# COPY prescript.sh /
# RUN chmod -v +x /prescript.sh

# Environment variable for application IP address
ENV APP_IP ${APP_IP:-localhost}

# Set the startup script as the default command
CMD ["/run-httpd.sh"]