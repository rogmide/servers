FROM php:7.4.33-fpm-alpine

WORKDIR /apps


RUN echo "UTC" > /etc/timezone

# Installing bash
RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing apps
RUN apk add git
RUN apk add libpng-dev
RUN apk add zlib-dev
RUN apk add libzip-dev
RUN apk add nodejs-current
RUN apk add npm

RUN npm install --global cross-env

# Adding git-ftp
RUN curl https://raw.githubusercontent.com/git-ftp/git-ftp/master/git-ftp > /bin/git-ftp
RUN chmod 755 /bin/git-ftp


# RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo pdo_mysql && docker-php-ext-enable pdo_mysql

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

RUN sed -i 's/user = www-data/user = nobody/g' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/group = www-data/group = nobody/g' /usr/local/etc/php-fpm.d/www.conf

RUN sed -i 's/;php_admin_value\[memory_limit\] = 32M/php_admin_value\[memory_limit\] = 512M/g' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /usr/local/etc/php/php.ini-production
RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /usr/local/etc/php/php.ini-development