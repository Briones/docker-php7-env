FROM ubuntu:xenial

MAINTAINER Roberto Briones <contacto@robertobriones.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN apt-get update && apt-get install -y -qq \
    apt-utils \
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
    php-redis && \
    rm -r /var/lib/apt/lists/*

RUN service php7.0-fpm stop

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN rm -rf /etc/php/7.0/fpm/pool.d/*
COPY conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN rm -f /etc/php/mods-available/xdebug.ini
COPY conf/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

CMD ["php-fpm7.0", "--nodaemonize"]
