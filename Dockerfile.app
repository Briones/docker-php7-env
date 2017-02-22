FROM ubuntu:xenial

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8

MAINTAINER Roberto Briones <contacto@robertobriones.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    librecode0 \
    libsqlite3-0 \
    libxml2 \
    software-properties-common --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

RUN apt-add-repository ppa:ondrej/php && apt-get update && apt-get install -y -qqq \
    php7.1-fpm \
    php7.1-cli \
    php7.1-curl \
    php7.1-dev \
    php7.1-intl \
    php7.1-json \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-opcache \
    php7.1-xml \
    php7.1-xmlrpc \
    php7.1-xsl \
    php-xdebug \
    php-ssh2 \
    php-redis \
    php-apcu \
    php-apcu-bc && \
    rm -r /var/lib/apt/lists/*

RUN service php7.1-fpm stop

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN rm -rf /etc/php/7.1/fpm/pool.d/*
COPY conf/www.conf /etc/php/7.1/fpm/pool.d/www.conf

RUN rm -f /etc/php/mods-available/xdebug.ini
COPY conf/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini

CMD ["php-fpm7.1", "--nodaemonize"]
