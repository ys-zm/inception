FROM debian:bullseye

#install all the program
RUN	apt update
RUN	apt install -y nginx=1.18.0-6.1+deb11u3 openssl=1.1.1w-0+deb11u1

RUN useradd -r nginx

# Creates a directory to store ssl cert and key
RUN mkdir /etc/nginx/ssl

# req -x509 makes it self signed trusted cert, no CA needed https://serverfault.com/questions/838774/how-is-a-self-signed-certificate-different-from-a-certificate-signing-request
# newkey generates a new key using -> rsa:2048 (2048 bit length key) 
# -subj specifies the subject of the cert, info about who uses the cert and where the server is that is using it
# left to right C(Country) L(Location) O(Organization) OU(Organizational Unit) CN(Common Name)
RUN openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=NL/ST=Noord Holland/L=Amsterdam/O=Codam/OU=Yesim/CN=yzaim"

RUN mkdir -p /run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

#COPY tools/entrypoint.sh /etc/entrypoint.sh
#RUN chmod +x /etc/entrypoint.sh
#ENTRYPOINT [ "/etc/entrypoint.sh" ]

CMD	["nginx", "-g", "daemon off;"]
