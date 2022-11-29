FROM php:8.1-fpm-alpine

RUN touch /var/log/error_log

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 wp && adduser -G wp -g wp -s /bin/sh -D wp

RUN mkdir -p /var/www/html

RUN chown wp:wp /var/www/html

WORKDIR /var/www/html

RUN apk add zlib zlib-dev libpng libpng-dev libzip-dev icu-dev

RUN docker-php-ext-install mysqli pdo pdo_mysql gd zip exif intl && docker-php-ext-enable pdo_mysql gd zip exif intl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp