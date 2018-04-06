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

drupal-8.5.1.tar.gz:
	wget https://ftp.drupal.org/files/projects/drupal-8.5.1.tar.gz

drupal_fetch: www drupal-8.5.1.tar.gz
	tar -xzf drupal-8.5.1.tar.gz --strip-components=1 -C www

drupal_start: drupal_fetch
	docker-compose up -d
