DRUPAL_VERSION ?= 8.5.1
build:
	docker-compose build

start: build
	docker-compose up

daemon: build
	docker-compose up -d

stop:
	docker-compose down

logs:
	@docker-compose logs -f

clean:
	docker-compose down -v
	sudo rm -rf www

www:
	mkdir www

www/html: www
	mkdir www/html

drupal-$(DRUPAL_VERSION).tar.gz:
	wget https://ftp.drupal.org/files/projects/drupal-$(DRUPAL_VERSION).tar.gz

www/html/index.php: www/html drupal-$(DRUPAL_VERSION).tar.gz
	sudo tar -xzf drupal-$(DRUPAL_VERSION).tar.gz --strip-components=1 -C www/html

drupal_unpack: www/html/index.php
	sudo chown -R www-data:www-data www
	sudo chmod -R g+rwX www

drupal_daemon: drupal_unpack
	docker-compose up -d

drupal: drupal_unpack build
	docker-compose up
