FROM alpine

RUN apk add --no-cache unbound openssl ripgrep mawk loksh coreutils doas curl tar gzip && \
	rm -f /etc/unbound/unbound.conf

RUN touch /etc/unbound/adblock.rpz
RUN touch /etc/unbound/custom.conf

COPY unablocker.crontab /tmp/unablocker.crontab
RUN /usr/bin/crontab /tmp/unablocker.crontab

COPY unbound.conf /etc/unbound/unbound.conf
COPY doas.conf /etc/doas.conf
COPY scripts /usr/local/bin

WORKDIR /etc/unbound

ENTRYPOINT ["entrypoint.sh"]
