FROM alpine:3.4
MAINTAINER Adam Wallner <wallner@bitbaro.hu>

ENV MARIADB_VER 10.2.2

ADD start.sh /opt/mariadb/start.sh
ADD my.cnf /etc/mysql/my.cnf

RUN apk add --no-cache \
    # Install utils
    pwgen openssl ca-certificates \
    # Install MariaDB build deps
    alpine-sdk cmake ncurses-dev gnutls-dev curl-dev libxml2-dev libaio-dev jemalloc-dev linux-headers bison \
    # Download and unpack
    && wget -O /tmp/mdb.tar.gz https://downloads.mariadb.org/interstitial/mariadb-${MARIADB_VER}/source/mariadb-${MARIADB_VER}.tar.gz \
    && cd /tmp && tar -xf mdb.tar.gz \
    # Build
    && cd /tmp/mariadb-${MARIADB_VER} \
    && cmake . -DBUILD_CONFIG=mysql_release -DWITHOUT_TOKUDB=1 \
    && make \
    # Install
    && make install \
    # Clean everything
    && rm -rf /tmp/* \
    && apk del \
    # Remove unneeded utils
    openssl ca-certificates \
    # Remove no more necessary build dependencies
    alpine-sdk cmake ncurses-dev gnutls-dev curl-dev libxml2-dev libaio-dev jemalloc-dev linux-headers bison \

    # Create needed directories
    && mkdir -p /etc/mysql/conf.d \
    && mkdir -p /opt/mariadb/pre-init.d \
    && mkdir -p /opt/mariadb/post-init.d \
    && mkdir -p /opt/mariadb/pre-exec.d \
    # Set permissions
    && chmod -R 755 /opt/mariadb

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/opt/mariadb/start.sh"]
