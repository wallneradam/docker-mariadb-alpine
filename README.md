# MariaDB (MySQL) image on Alpine Linux

## Docker image usage

```
docker run [docker-options] pickapp/mariadb-alpine
```

Note that MySQL root will be randomly generated (using pwgen).
Root password will be displayed, during first run using output similar to this:
```
[i] MySQL root Password: XXXXXXXXXXXXXXX
```

But you don't need root password. If you connect locally, it should not
ask you for password, so you can use following procedure:
```
docker exec -ti mariadb_containerid /bin/sh
# mysql -u root mysql
```

## Examples

Typical usage:

```
docker run -ti -v /host/dir/for/db:/var/lib/mysql -e MYSQL_DATABASE=db -e MYSQL_USER=user -e MYSQL_PASSWORD=blah k0st/alpine-mariadb
```
