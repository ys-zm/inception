FROM debian:bullseye

#install all the program
RUN	apt update
RUN	apt install -y nginx=1.18.0-6.1+deb11u3 openssl=1.1.1w-0+deb11u1

RUN useradd -r nginx

# Creates a directory to store ssl cert and key
RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/yzaim.key -out /etc/nginx/ssl/yzaim.crt \
    -subj "/C=NL/ST=Noord Holland/L=Amsterdam/O=Codam/OU=Yesim/CN=yzaim"

RUN mkdir -p /run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

#COPY tools/entrypoint.sh /etc/entrypoint.sh
#RUN chmod +x /etc/entrypoint.sh
#ENTRYPOINT [ "/etc/entrypoint.sh" ]

CMD	["nginx", "-g", "daemon off;"]
