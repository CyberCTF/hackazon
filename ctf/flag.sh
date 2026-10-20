#!/bin/sh
# >>> isoloom-1.0 secret-from-file shim (auto-added by convert-lab.py) >>>
# Inputs now arrive as files (isoloom.yml `files:`), not environment variables.
# Read each into its old variable when unset, keeping the dev/CI fallback working.
for __p in CTF_FLAG_MAIN:/run/lab/ctf_flag_main; do
  __n=${__p%%:*}; __f=${__p#*:}
  eval "__v=\${$__n:-}"
  if [ -z "$__v" ] && [ -s "$__f" ]; then
    __v=$(tr -d '\r\n' < "$__f"); eval "export $__n=\"\$__v\""
  fi
done
unset __p __n __f __v 2>/dev/null || true
# <<< isoloom-1.0 secret-from-file shim <<<
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) in the table flags of a ctf
# database the store's database user can read, where the store's SQL injections reach it (the
# installer drops every table of the hackazon database, so the flag lives next to it);
# without one (CI, a run by hand) the development flag.
dev='FLAG{dev-hackazon}'
flag=$(printf '%s' "${CTF_FLAG_MAIN:-$dev}" | sed "s/'/''/g")
i=0; until mariadb -h127.0.0.1 -uroot -phackazon-root -e 'SELECT 1' >/dev/null 2>&1; do i=$((i+1)); [ $i -gt 150 ] && exit 1; sleep 2; done
mariadb -h127.0.0.1 -uroot -phackazon-root -e "CREATE DATABASE IF NOT EXISTS ctf; CREATE TABLE IF NOT EXISTS ctf.flags (flag VARCHAR(255) NOT NULL); DELETE FROM ctf.flags; INSERT INTO ctf.flags (flag) VALUES ('$flag'); GRANT SELECT ON ctf.* TO 'hackazon'@'%';"
