FROM php:8.2.3-fpm-alpine

WORKDIR /apps


RUN echo "UTC" > /etc/timezone

# Installing bash
RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing git
RUN apk add git

RUN docker-php-ext-install mysqli
# RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql && docker-php-ext-enable pdo_mysql

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

RUN sed -i 's/user = www-data/user = nobody/g' /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/group = www-data/group = nobody/g' /usr/local/etc/php-fpm.d/www.conf