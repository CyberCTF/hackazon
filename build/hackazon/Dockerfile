# Hackazon ships no Dockerfile (upstream: a PHP 5.4+ / Apache / MySQL 5.5 host with web/ as the
# document root and its install wizard at /install). This image does that on PHP 5.6 with Apache:
# the source from app/ goes to /var/www/hackazon/ with web/ as the document root and mod_rewrite
# on; the db, email, parameters and rest configs are created from upstream's *.sample.php files
# with the database host and account of the db machine; and the command first starts
# install.sh in the background, which runs upstream's install wizard once so the lab starts ready.
FROM docker.io/library/php:5.6-apache

RUN docker-php-ext-install pdo_mysql mysqli bcmath \
 && a2enmod rewrite headers \
 && sed -i 's#/var/www/html#/var/www/hackazon/web#' /etc/apache2/sites-available/000-default.conf \
 && printf '<Directory /var/www/hackazon/web>\n  AllowOverride All\n  Require all granted\n</Directory>\n' \
      > /etc/apache2/conf-enabled/hackazon.conf \
 && printf 'date.timezone = UTC\n' > /usr/local/etc/php/conf.d/hackazon.ini

COPY --chown=www-data:www-data app/ /var/www/hackazon/
WORKDIR /var/www/hackazon
RUN cd assets/config \
 && sed -e "s/'yourdbpass'/'hackazon'/" -e 's/host=localhost/host=db/' -e "s/'host' => 'localhost'/'host' => 'db'/" \
      db.sample.php > db.php \
 && cp email.sample.php email.php && cp parameters.sample.php parameters.php && cp rest.sample.php rest.php \
 && mkdir -p vuln ../../web/user_pictures && chown -R www-data:www-data /var/www/hackazon

COPY install.sh /usr/local/bin/hackazon-install
CMD ["sh", "-c", "sh /usr/local/bin/hackazon-install & exec apache2-foreground"]
