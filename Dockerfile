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
    unzip \
    wget

# Configure apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN rm /var/www/html/index.html

# Create a user
RUN useradd -ms /bin/bash watzekdi
RUN adduser watzekdi sudo

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

EXPOSE 80

VOLUME ["/var/www/html"]

ENTRYPOINT service apache2 start
