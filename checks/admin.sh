#!/bin/sh
# admin / hackazon (set by the install wizard) logs in to the back office.
set -e
jar=$(mktemp)
curl -fsS -c "$jar" -b "$jar" -o /dev/null http://hackazon/admin/user/login
curl -fsS -c "$jar" -b "$jar" -o /dev/null --data "username=admin&password=hackazon" http://hackazon/admin/user/login
page=$(curl -fsS -c "$jar" -b "$jar" http://hackazon/admin/)
echo "$page" | grep -qi "logout"
