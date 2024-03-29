FROM alpine

RUN apk add --no-cache unbound openssl ripgrep mawk loksh coreutils doas curl tar gzip && \
	rm -f /etc/unbound/unbound.conf

RUN touch /etc/unbound/adblock.rpz

COPY unablocker.crontab /tmp/unablocker.crontab
RUN /usr/bin/crontab /tmp/unablocker.crontab
RUN /usr/sbin/crond -l 0 -L /var/log/cron.log

COPY unbound.conf /etc/unbound/unbound.conf
COPY doas.conf /etc/doas.conf
COPY scripts /usr/local/bin

WORKDIR /etc/unbound

ENTRYPOINT ["entrypoint.sh"]
