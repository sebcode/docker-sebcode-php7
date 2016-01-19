FROM ubuntu:wily

MAINTAINER Sebastian Volland

# Fetch pub key for nginx repos
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62

# Fetch pub key for PHP repos
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

RUN echo "\
deb mirror://mirrors.ubuntu.com/mirrors.txt wily main restricted universe\n\
deb mirror://mirrors.ubuntu.com/mirrors.txt wily-updates main restricted universe\n\
deb mirror://mirrors.ubuntu.com/mirrors.txt wily-backports main restricted universe\n\
deb mirror://mirrors.ubuntu.com/mirrors.txt wily-security main restricted universe\n\
\n\
# For latest nginx\n\
deb http://nginx.org/packages/mainline/ubuntu/ wily nginx\n\
\n\
# For PHP 7\n\
deb http://ppa.launchpad.net/ondrej/php/ubuntu wily main\n\
"> /etc/apt/sources.list

RUN apt-get -y update

RUN apt-get install -y \
  nginx

RUN apt-get install -y \
  php-pear \
  php7.0-cli \
  php7.0-common \
  php7.0-curl \
  php7.0-fpm \
  php7.0-imap \
  php7.0-json \
  php7.0-mysql \
  php7.0-readline \
  php7.0-gd \
  php7.0-opcache \
  php7.0-gmp \
  php7.0-intl \
  php7.0-mcrypt \
  php7.0-xsl \
  php7.0-bz2 \
  php7.0-sqlite3

# php5-sqlite \
# php5-imagick \
# php5-mysqlnd \
# php5-pecl-http \
# php5-propro \
# php5-raphf \
# php5-xdebug

# for add-apt-repository
RUN apt-get install -y \
  software-properties-common

RUN mkdir /etc/nginx/ssl
ADD tmpcert.pem /etc/nginx/ssl/default.crt
ADD tmpcert.key /etc/nginx/ssl/default.key

ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www
RUN echo '<?php phpinfo() ?>' > /var/www/index.php

RUN echo "\
service php7.0-fpm start\n\
nginx -g 'daemon off;'\n\
"> /root/bootstrap.sh

RUN chmod +x /root/bootstrap.sh

EXPOSE 443

CMD /root/bootstrap.sh

