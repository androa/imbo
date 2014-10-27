# DOCKER-VERSION 1.0.1
FROM ubuntu:14.04

# Install necessary software for Imbo Web servers.
RUN apt-get update && apt-get -y install curl php5 apache2 php5-json php5-imagick php5-mongo php5-memcached

# Add the source code of Imbo
COPY . /imbo

# Install necessary Imbo dependencies.
RUN cd /imbo; curl -sS https://getcomposer.org/installer | php
RUN cd /imbo; php composer.phar install --no-dev -o

# Expose Apache config
RUN ln -s /imbo/config/imbo.apache.conf /etc/apache2/sites-enabled/001-imbo.conf
RUN a2enmod rewrite

# Expose Imbo
EXPOSE 80

# Start Imbo
ENTRYPOINT ["apache2ctl"]

CMD ["-D FOREGROUND"]
