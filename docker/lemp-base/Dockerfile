#Ubuntu 20.04 Base Image - Nginx + MySQL + PHP 7.4 [LEMP]
FROM ubuntu:20.04

#Label
LABEL version="2.0"
LABEL name="ubuntu-base+nginx+mysql+php"

#Set TZ
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#apt update & install
RUN apt-get update && apt-get install -y \
        git \
        curl \
        libpng-dev \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
        zip \
        unzip \
        graphviz \
        npm \
        libxpm4 \
        libxrender1 \
        libgtk2.0-0 \
        libnss3 \
        libgconf-2-4 \
        chromium-browser \
        xvfb \
        gtk2-engines-pixbuf \
        xfonts-cyrillic \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-base \
        xfonts-scalable \
        imagemagick x11-apps \
        libwebp-dev \
        libfreetype6-dev \
        libjpeg62-dev \
        libpng-dev libxpm-dev \
        php-fpm \
        php-cli \
        php-common \
        php-zip \
        php-mbstring \
        php-bcmath \
        php-image-text \
        php-gd \
        php-mysql \
        composer \
        nginx \
        mysql-server \
        mysql-client \
        mysql-common \
        php-xml \
        php-curl