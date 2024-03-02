FROM php:7.4-fpm

# 安装系统依赖
RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev \
#        git \
#        unzip \
        zip libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 GD, mysql pdo 扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip && docker-php-ext-install bcmath && pecl install redis && docker-php-ext-enable redis

# 设置工作目录
#WORKDIR /var/www/html
#COPY ./src .

## 安装 Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
#    && composer install \
#    && chown -R www-data:www-data /var/www/html
