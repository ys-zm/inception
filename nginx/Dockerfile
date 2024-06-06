FROM debian:buster

#install all the program
RUN	apt-get update
RUN	apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes

RUN mkdir -p /run/nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d

ENTRYPOINT ["nginx", "-g", "daemon off;"]
