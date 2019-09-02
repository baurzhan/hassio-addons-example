#!/bin/bash -e
FILE=/data/user-id
cat $FILE
if [ ! -f $FILE ]; then
	(/bin/cat /dev/urandom || true) | (/usr/bin/tr -dc "a-z0-9" || true) | (/usr/bin/fold -w 12 || true) | (/usr/bin/head -n 1 || true) | (tee $FILE || true)
fi
/usr/bin/supervisord -c /supervisord.conf
