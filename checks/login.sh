#!/bin/sh
# test_user / 123456 logs in to the store, which proves the install wizard loaded the database.
set -e
jar=$(mktemp)
curl -fsS -c "$jar" -b "$jar" -o /dev/null http://hackazon/user/login
curl -fsS -c "$jar" -b "$jar" -o /dev/null --data "username=test_user&password=123456" http://hackazon/user/login
page=$(curl -fsS -c "$jar" -b "$jar" http://hackazon/account)
echo "$page" | grep -q "test_user"
