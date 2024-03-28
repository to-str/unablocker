#!/bin/sh
# turn on job control
set -m

for i in server control; do
	if [ ! -f /etc/unbound/unbound_$i.key ] ||
		[ ! -f /etc/unbound/unbound_$i.pem ]; then
			unbound-control-setup && break
	fi
done

unbound-anchor -a /etc/unbound/root.key
curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache
chown -R unbound:unbound /etc/unbound


exec unbound -dp &

unbound-adblock.sh -D -O alpine -F curl -W /etc/unbound/adblock.rpz
/usr/sbin/crond -f -d 0

fg %1
