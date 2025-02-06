FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install php7.4 curl wget php7.4-fpm php-mysql mariadb-client php-redis php-curl -y

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.6-fr_FR.tar.gz && rm wordpress-6.6-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY setup.sh /var/www/
RUN chmod +x /var/www/setup.sh

EXPOSE 9000

CMD ["./var/www/setup.sh"]