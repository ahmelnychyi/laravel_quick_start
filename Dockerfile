FROM php:7.4-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

ARG user
ARG uid

# ��������� ������������
RUN apt-get update && apt-get install -y \
git \
curl \
libpng-dev \
libonig-dev \
libxml2-dev \
zip \
unzip

# ������ ����
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# ��������� ���������� PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# ��������� ��������� ������ Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# �������� ���������� ������������ ��� ������� ������ Composer � Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
chown -R $user:$user /home/$user

# �������� �������� ��������
WORKDIR /var/www

USER $user
