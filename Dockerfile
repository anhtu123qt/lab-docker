FROM php:8.1.20-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl libcurl4-openssl-dev \
    libpq-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libmagick++-dev \
    libmagickwand-dev \
    zip \
    unzip

RUN docker-php-ext-install bcmath curl
RUN docker-php-ext-install exif
RUN docker-php-ext-install mbstring mysqli
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo_mysql pdo_pgsql pgsql

RUN pecl install imagick && \
    docker-php-ext-enable imagick

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

COPY ./composer.* ./

RUN composer install --prefer-dist --no-scripts --no-progress --no-interaction

COPY . .

RUN composer dump-autoload --optimize

RUN chmod -R 777 storage

RUN chmod -R 777 bootstrap/cache

RUN php artisan optimize:clear
