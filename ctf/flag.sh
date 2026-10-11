#!/bin/sh
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) in the table flags of a ctf
# database the store's database user can read, where the store's SQL injections reach it (the
# installer drops every table of the hackazon database, so the flag lives next to it);
# without one (CI, a run by hand) the development flag.
dev='FLAG{dev-hackazon}'
flag=$(printf '%s' "${CTF_FLAG_MAIN:-$dev}" | sed "s/'/''/g")
i=0; until mariadb -h127.0.0.1 -uroot -phackazon-root -e 'SELECT 1' >/dev/null 2>&1; do i=$((i+1)); [ $i -gt 150 ] && exit 1; sleep 2; done
mariadb -h127.0.0.1 -uroot -phackazon-root -e "CREATE DATABASE IF NOT EXISTS ctf; CREATE TABLE IF NOT EXISTS ctf.flags (flag VARCHAR(255) NOT NULL); DELETE FROM ctf.flags; INSERT INTO ctf.flags (flag) VALUES ('$flag'); GRANT SELECT ON ctf.* TO 'hackazon'@'%';"
