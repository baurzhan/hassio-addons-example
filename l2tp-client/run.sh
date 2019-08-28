#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

TARGET=$(jq --raw-output ".target" $CONFIG_PATH)
USERNAME=$(jq --raw-output ".username" $CONFIG_PATH)
PASSWORD=$(jq --raw-output ".password" $CONFIG_PATH)
NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
access control = no
auth file = /etc/ppp/pap-secrets
debug avp = yes
debug network = yes
debug packet = yes
debug state = yes
debug tunnel = yes

[lac home]
lns = $TARGET
redial = yes
redial timeout = 1
require chap = no
require authentication = no
ppp debug = yes
pppoptfile = /etc/ppp/options.l2tpd
require pap = yes
autodial = yes
bps = 1000000
EOF

cat > /etc/ppp/options.l2tpd <<EOF
ipcp-accept-local
ipcp-accept-remote
refuse-eap
#require-mschap-v2
noccp
noauth
noaccomp
idle 1800
mtu 1410
mru 1410
defaultroute
usepeerdns
debug
connect-delay 5000
name smarthome
user $NEW_UUID
password smarthome
EOF

mkdir -p /var/run/xl2tpd
rm -f /var/run/xl2tpd.pid
exec /usr/sbin/xl2tpd -D -c /etc/xl2tpd/xl2tpd.conf
