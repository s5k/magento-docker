#!/usr/bin/env sh

if [[ "$VERBOSE" == "true" ]]; then
	touch /usr/local/var/log/php-fpm.log
	chown nobody:nobody /usr/local/var/log/php-fpm.log
	tail -f /usr/local/var/log/php-fpm.log &
fi

chown -R nobody:nobody /var/www
/var/www/bin/magento cron:install
php-fpm -F

