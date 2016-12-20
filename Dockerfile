FROM alpine:3.4
MAINTAINER Adam Wallner <wallner@bitbaro.hu>

ADD start.sh /opt/mariadb/start.sh

RUN apk add --no-cache mysql mysql-client pwgen \
    && mkdir -p /opt/mariadb/pre-exec.d \
    && mkdir -p /opt/mariadb/pre-init.d \
    && chmod -R 755 /opt/mariadb

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/opt/mariadb/start.sh"]
