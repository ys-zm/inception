FROM debian:bullseye
RUN apt update

# RUN apt install -y mariadb-server=1:10.5.23-0+deb11u1 vim wget git mycli zsh
#RUN apt-get install -y wget curl php php-cgi php-mysql php-fpm php-pdo php-cli php-gd php-mbstring
RUN apt-get install -y wget curl php php-cgi php-mysql php-fpm php-pdo php-cli php-gd php-mbstring mariadb-server

COPY ./tools/entrypoint.sh /etc/entrypoint.sh
#RUN chown mysql:root /etc/entrypoint.sh && chmod +x /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh


COPY ./tools/healthcheck.sh /etc/healthcheck.sh
#RUN chown mysql:root /etc/healthcheck.sh && chmod +x /etc/healthcheck.sh
RUN chmod +x /etc/healthcheck.sh


//COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
//RUN chown -R mysql:root /etc/mysql/mariadb.conf.d

ENTRYPOINT ["/etc/entrypoint.sh"]
