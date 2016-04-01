FROM ubuntu:trusty

MAINTAINER Roberto Briones <contacto@robertobriones.com>

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8

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

RUN apt-add-repository ppa:ondrej/php && apt-get update && apt-get install -y -qq \
    php7.0-fpm \
    php7.0-cli \
    php7.0-curl \
    php7.0-dev \
    php7.0-intl \
    php7.0-json \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-opcache \
    php7.0-xml \
    php7.0-xmlrpc \
    php7.0-xsl \
    php-xdebug \
    php-ssh2 \
    php-redis \
    php-apcu \
    php-apcu-bc && \
    rm -r /var/lib/apt/lists/*

RUN service php7.0-fpm stop

RUN rm -rf /etc/php/7.0/fpm/pool.d/*
COPY conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN rm -f /etc/php/mods-available/xdebug.ini
COPY conf/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

CMD ["php-fpm7.0", "--nodaemonize"]
