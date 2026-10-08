#!/bin/sh
# The REST API (used by the mobile app) returns a token for test_user.
set -e
out=$(curl -fsS -u test_user:123456 http://hackazon/api/auth)
echo "$out" | grep -q "token"
