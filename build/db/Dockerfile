# The MySQL 5.5 database Hackazon was written for, as MariaDB 10.11 with the values baked in:
# Hackazon connects as hackazon / hackazon to the hackazon database (set in
# build/hackazon/Dockerfile), and the server runs with MySQL 5.5's permissive SQL mode.
FROM docker.io/library/mariadb:10.11
ENV MARIADB_ROOT_PASSWORD=hackazon-root \
    MARIADB_DATABASE=hackazon \
    MARIADB_USER=hackazon \
    MARIADB_PASSWORD=hackazon
CMD ["mariadbd", "--sql-mode=NO_ENGINE_SUBSTITUTION"]
