FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
    procps \
    vim \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install pdo_mysql -j$(nproc) gd

# RUN addgroup -S www-data && adduser -S www-data -G www-data
# USER www-data

WORKDIR /var/www/html

# set development config
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN sed -i 's/;session.save_path = "\/tmp"/session.save_path = "\/var\/www\/sessions"/g' "$PHP_INI_DIR/php.ini"

# Save log to file
RUN sed -i 's/;error_log = log\/php-fpm.log/error_log = \/var\/www\/logs\/php-fpm.log/g' "$PHP_INI_DIR/../php-fpm.conf"

# Configurate php-fpm to run on socket instead of tcp
RUN sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/fpm_sockets\/new.advayta.org.sock/g' "$PHP_INI_DIR/../php-fpm.d/www.conf"
RUN sed -i 's/listen = 9000/listen = \/var\/run\/fpm_sockets\/new.advayta.org.sock/g' "$PHP_INI_DIR/../php-fpm.d/zz-docker.conf"

# Capture fpm output to stdout and stderr
RUN sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' "$PHP_INI_DIR/../php-fpm.d/www.conf"
RUN sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' "$PHP_INI_DIR/../php-fpm.d/zz-docker.conf"

# Make sure cgi.fix_pathinfo is off
# RUN echo 'cgi.fix_pathinfo=0' >> $PHP_INI_DIR/../php-fpm.d/www.conf
# RUN echo 'cgi.fix_pathinfo=0' >> $PHP_INI_DIR/../php-fpm.d/zz-docker.conf

# Fix socket file permissions
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' "$PHP_INI_DIR/../php-fpm.d/www.conf"
RUN sed -i 's/;listen.group = www-data/listen.group = www-data/g' "$PHP_INI_DIR/../php-fpm.d/www.conf"
RUN sed -i 's/;listen.mode = /listen.mode = /g' "$PHP_INI_DIR/../php-fpm.d/www.conf"
RUN sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' "$PHP_INI_DIR/../php-fpm.d/zz-docker.conf"
RUN sed -i 's/;listen.group = www-data/listen.group = www-data/g' "$PHP_INI_DIR/../php-fpm.d/zz-docker.conf"
RUN sed -i 's/;listen.mode = /listen.mode = /g' "$PHP_INI_DIR/../php-fpm.d/zz-docker.conf"

# we are using sockets no need to expose
# EXPOSE 9000
