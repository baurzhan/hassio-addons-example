#!/bin/bash -e
if [ ! -f /user-id ]; then
	(/bin/cat /dev/urandom || true) | (/usr/bin/tr -dc "a-z0-9" || true) | (/usr/bin/fold -w 12 || true) | (/usr/bin/head -n 1 || true) | (tee /user-id || true)
fi
/usr/bin/supervisord -c /supervisord.conf
