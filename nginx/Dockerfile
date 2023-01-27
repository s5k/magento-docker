FROM alpine:3.6

RUN apk --update --no-cache add \
	shadow \
	openssl \
	nginx

RUN usermod -u 1000 nginx && \
	groupmod -g 1000 nginx

RUN mkdir -p /var/ssl && \
	openssl req \
		-x509 \
		-nodes \
		-days 365 \
		-newkey rsa:2048 \
		-out /var/ssl/nginx.crt \
		-keyout /var/ssl/nginx.key \
		-subj "/C=US/ST=IL/L= /O= /OU= /CN= "

COPY ./bin/startup.sh /usr/local/bin/startup.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/https.conf /etc/nginx/conf.d/https.conf

### non-cache section ###
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
COPY ./conf/magento-2.conf /etc/nginx/available.d/magento-2.conf

CMD [ "sh", "/usr/local/bin/startup.sh" ]
