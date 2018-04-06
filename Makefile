DRUPAL_VERSION ?= 8.5.1
start:
	docker-compose up

daemon:
	docker-compose up -d

stop:
	docker-compose down

logs:
	@docker-compose logs -f

www:
	mkdir www

www/html: www
	mkdir www/html

drupal-$(DRUPAL_VERSION).tar.gz:
	wget https://ftp.drupal.org/files/projects/drupal-$(DRUPAL_VERSION).tar.gz

www/html/index.php: www/html
	tar -xzf drupal-$(DRUPAL_VERSION).tar.gz --strip-components=1 -C www/html

drupal_unpack: www/html/index.php

drupal_daemon: drupal_unpack
	docker-compose up -d

drupal: drupal_unpack
	docker-compose up
