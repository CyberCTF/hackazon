#!/bin/sh
# Runs Hackazon's install wizard (/install: admin password, database, email, confirmation) once
# Apache and the database answer, so the lab starts ready: admin / hackazon. Skipped when the
# database already holds Hackazon's tables, so a restart keeps it as the player left it.
installed() {
  php -r '$c=@new mysqli("db","hackazon","hackazon","hackazon"); exit(!$c->connect_errno && $c->query("SELECT 1 FROM tbl_products LIMIT 1") ? 0 : 1);' 2>/dev/null
}
jar=/tmp/hackazon-install.cookies
post() { curl -fsS -c "$jar" -b "$jar" -o /dev/null "$@" 2>/dev/null; }
for i in $(seq 1 90); do
  if installed; then echo "hackazon-install: installed"; rm -f "$jar"; exit 0; fi
  if php -r 'exit(@new mysqli("db","hackazon","hackazon","hackazon") && !mysqli_connect_errno() ? 0 : 1);' 2>/dev/null; then
    rm -f "$jar"
    post -L http://127.0.0.1/install
    post --data 'password=hackazon&password_confirmation=hackazon' http://127.0.0.1/install/admin_credentials
    post --data 'host=db&port=3306&user=hackazon&password=hackazon&db=hackazon' http://127.0.0.1/install/db_settings
    post --data 'type=sendmail' http://127.0.0.1/install/email_settings
    post --max-time 300 --data 'version=1' http://127.0.0.1/install/confirmation
  fi
  sleep 2
done
echo "hackazon-install: install failed"; exit 1
