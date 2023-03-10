FROM php:7.4-fpm-alpine3.12

RUN apk --update --no-cache add \
	freetype-dev \
	libjpeg-turbo-dev \
	icu-dev \
	libxslt-dev \
	libzip-dev \
	git

RUN apk --update --no-cache --virtual build-deps add \
	g++ \
	shadow \
	curl-dev \
	oniguruma-dev \
	libpng-dev \
	libxml2-dev \
	zlib-dev

RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/

RUN docker-php-ext-install \
	bcmath \
	gd \
	intl \
	pdo_mysql \
	soap \
	sockets \
	xsl \
	zip \
	opcache 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug,develop,profile" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.output_dir=/var/www/var/codeprofiling/profiles" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN mkdir -p /var/www/var/codeprofiling/profiles \
    && chmod -R 777 /var/www/var/codeprofiling/profiles

RUN curl -LkSso /usr/bin/mhsendmail 'https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64'&& \
    chmod 0755 /usr/bin/mhsendmail

# Set the user and group ID
ARG UID=1001
ARG GID=1001
RUN usermod -u $UID www-data && \
    groupmod -g $GID www-data
RUN usermod -u $UID nobody && \
	groupmod -g $GID nobody

COPY ./bin/startup.sh /usr/local/bin/startup.sh
COPY ./conf/php.ini /usr/local/etc/php/php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk del build-deps

### non-cache section ###
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN sed -i -e 's/^xdebug.mode=debug,develop,profile/xdebug.mode=off/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


CMD [ "sh", "/usr/local/bin/startup.sh" ]
