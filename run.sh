#!/bin/bash

# add php settings
echo upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE} >> /usr/local/etc/php/conf.d/php.ini
echo post_max_size = ${PHP_POST_MAX_SIZE} >> /usr/local/etc/php/conf.d/php.ini

# add mysql database settings for omeka
echo -e host = \"${OMEKA_DB_HOST}\" >> /var/www/Omeka/db.ini
echo -e username = \"${OMEKA_DB_USER}\" >> /var/www/Omeka/db.ini
echo -e password = \"${OMEKA_DB_PASSWORD}\" >> /var/www/Omeka/db.ini
echo -e dbname = \"${OMEKA_DB_NAME}\" >> /var/www/Omeka/db.ini
echo -e prefix = \"${OMEKA_DB_PREFIX}\" >> /var/www/Omeka/db.ini
echo -e charset = \"${OMEKA_DB_CHARSET}\" >> /var/www/Omeka/db.ini

# enable verbose errors if we're in development
if [ "$APPLICATION_ENV" = "development" ]; then
    echo SetEnv APPLICATION_ENV development >> .htaccess
fi

# start apache
source /etc/apache2/envvars
exec apache2 -D FOREGROUND
