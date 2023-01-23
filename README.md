# Docker Magento

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

A Docker build specifically for Magento that utilizes Alpine images for optimal performance.

## Features

- PHP 7.4 and Nginx.
- XDebug - Debug,Profile,Coverage out of the box.
- MySQL 8.0.
- Elasticsearch 7.
- Mailhog for SMTP.

## Installation

Clone the Repo into your Magento project and configuration.

```sh
git submodule add git@github.com:s5k/magento-docker.git docker
cd docker
cp .env.example .env
```

Edit your domain in field `server_name` at file:
```sh
nginx/conf/magento-2.conf
```

Start the containers
```sh
docker-compose up -d
```

Edit your domain in `/etc/hosts`:

```sh
127.0.0.1   yourdomain.local
```

Create/import database.
Configure Elasticsearch, table `core_config_data` with path column `catalog/search/elasticsearch7_server_hostname` and change `value` column to:
```sh
elasticsearch
```
## Usage
If you would like to access the php-docker terminal:
```sh
docker-compose exec -it php sh
```
## Contribution

I would be grateful if you would like to contribute to my project. Please let me know if you are interested. Thank you.




## License

MIT

**Happy Coding!**

