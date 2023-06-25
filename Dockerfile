FROM php:8.1.20-fpm-alpine3.18

RUN apk update && apk add \
    git \
    make \
    libmcrypt-dev \
    openssl-dev \
    php81-openssl \
    php81-pdo_mysql \
    php81-mbstring \
    php81-pcntl \
    php81-intl

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo_mysql

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

COPY ./composer.* ./

RUN composer install --prefer-dist --no-scripts --no-progress --no-interaction

COPY . .

RUN composer dump-autoload --optimize

RUN chmod -R 777 storage

RUN chmod -R 777 bootstrap/cache

RUN php artisan optimize:clear
