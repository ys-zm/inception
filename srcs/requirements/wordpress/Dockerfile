FROM debian:bullseye

# update the system
RUN apt update

# install the required packages
#RUN apt install php7.4=7.4.33-1+deb11u5 \
 #               php7.4-mysql=7.4.33-1+deb11u5 \
  #              php7.4-fpm=7.4.33-1+deb11u5 \
   #             curl=7.74.0-1.3+deb11u11

RUN apt-get install -y wget curl php php-cgi php-mysql php-fpm php-pdo php-cli php-gd php-mbstring netcat
#RUN rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

EXPOSE 9000

# copy the wordpress configuration script into the root directory of the container
COPY ./tools/entrypoint.sh /etc/entrypoint.sh

# change the permissions to make it executable
RUN  chmod +x /etc/entrypoint.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["/etc/entrypoint.sh"]

# Don't daemonize `-F`
CMD ["/usr/sbin/php-fpm7.4", "-F"]
