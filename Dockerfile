FROM ubuntu:xenial
MAINTAINER Nick Budak <budak@lclark.edu>, Rishi Javia <rishijavia@lclark.edu>

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    apache2 \
    imagemagick \
    libapache2-mod-php \
    mysql-server \
    php-mysql \    
    pwgen \
    supervisor \
    unzip \
    wget

# Create a user
RUN useradd -m -p  /bin/bash watzekdi
RUN usermod --password $(echo omeka | openssl passwd -1 -stdin) watzekdi
RUN adduser watzekdi sudo

# Add scripts and conf files
ADD run.sh /run.sh
ADD create-mysql-admin-user.sh /create-mysql-admin-user.sh
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
RUN chmod 755 /*.sh

# Configure apache
ADD apache-omeka /etc/apache2/sites-available/omeka.conf
RUN a2enmod rewrite
RUN a2ensite omeka

# Configure mysql
RUN rm -rf /var/lib/mysql/*
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

# Configure php
ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 100M

# Install omeka
RUN wget http://omeka.org/files/omeka-2.4.1.zip && unzip omeka-2.4.1.zip
RUN mv omeka-2.4.1/* /var/www/html
RUN mv omeka-2.4.1/.htaccess /var/www/html
RUN groupadd webdev
RUN usermod -a -G webdev watzekdi
WORKDIR /var/www
RUN chown -R root.webdev html && chmod 775 html
WORKDIR /var/www/html
RUN find . -type d | xargs chmod 775
RUN find . -type f | xargs chmod 664
RUN find files -type d | xargs chmod 777
RUN find files -type f | xargs chmod 666

# Run the server
EXPOSE 80 3306
CMD ["/run.sh"]
