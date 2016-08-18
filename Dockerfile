FROM php:7.0-apache
MAINTAINER Nick Budak <budak@lclark.edu>, Rishi Javia <rishijavia@lclark.edu>

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git imagemagick
RUN docker-php-ext-install exif mysqli

# Install omeka
WORKDIR /var/www
RUN git clone https://github.com/omeka/Omeka.git
RUN chown -R root.www-data Omeka && chmod 775 Omeka
WORKDIR /var/www/Omeka
RUN rm db.ini.changeme
ADD db.ini ./db.ini
RUN rm .htaccess.changeme
ADD .htaccess ./.htaccess
RUN rm application/config/config.ini.changeme
ADD config.ini application/config/config.ini
RUN mv application/logs/errors.log.empty application/logs/errors.log
RUN find . -type d | xargs chmod 775
RUN find . -type f | xargs chmod 664
RUN find files -type d | xargs chmod 777
RUN find files -type f | xargs chmod 666

# Configure apache
ADD omeka.conf /etc/apache2/sites-available/omeka.conf
RUN a2enmod rewrite
RUN a2ensite omeka
RUN a2dissite 000-default
ENV APPLICATION_ENV development

# Configure php
ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 100M

# Configure mysql
ENV OMEKA_DB_HOST localhost
ENV OMEKA_DB_USER root
ENV OMEKA_DB_PASSWORD password
ENV OMEKA_DB_NAME omeka
ENV OMEKA_DB_PREFIX _omeka
ENV OMEKA_DB_CHARSET utf8

# Add init script
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Run the server
VOLUME /var/www/Omeka
CMD ["/run.sh"]
