FROM php:7.4-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

ARG user
ARG uid

# установка зависимостей
RUN apt-get update && apt-get install -y \
git \
curl \
libpng-dev \
libonig-dev \
libxml2-dev \
zip \
unzip

# чистка кэша
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# установка расширений PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# получение последней версии Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# создание системного пользователя для запуска команд Composer и Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
chown -R $user:$user /home/$user

# создание рабочего каталога
WORKDIR /var/www

USER $user
