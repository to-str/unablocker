# unablocker

## Description

unablocker, a combination of unbound and adblock, is a container that acts as a DNS server while also blocking a lot of unwanted ad networks.

It is based on
- [unbound](https://nlnetlabs.nl/projects/unbound/about/) by NLnet Labs
- [unbound-adblock](https://www.geoghegan.ca/unbound-adblock.html) by Jordan Geoghegan
- [alpine docker image](https://gitlab.alpinelinux.org/alpine/infra/docker/unbound) by Carlo Landmeter

The image from alpine is not pulled, I adapted the original Dockerfile to make everything easy to follow. If you run this container you need to map port 53. Unbound with the default config is running as a recursive, iterative resolver, and does not forward queries to other DNS servers. This can easily be changed in the config. The docker image can be found [here](https://hub.docker.com/repository/docker/tostr7191/unablocker/general).

## Running

Simplest way to run the container:
```
docker pull tostr7191/unablocker:latest
docker run -dit -p53:53/udp --name unablocker tostr7191/unablocker:latest
```

With docker compose:
```
---
services:
  unablocker:
    image: tostr7191/unablocker:latest
    container_name: unablocker
    volumes:
      - ./custom.conf:/etc/unbound/custom.conf #optional
      ## if you want to change more basic aspects
      #- ./unbound.conf:/etc/unbound/unbound.conf
    ports:
      - 53:53/udp
    restart: unless-stopped
```

Unbound looks for `/etc/unbound/custom.conf`, which is empty by default. If you just want to add some configuration for your local network, this would be a good place to put it. In this way your custom config is separate from the core config, which might change. It is included at the end of the `server:`-block.

```
docker pull tostr7191/unablocker:latest
docker run -dit -p53:53/udp \
-v /path/to/custom.conf:/etc/unbound/custom.conf \
--name unablocker tostr7191/unablocker:latest
```

## Noteworthy

If you get warnings about `so-rcvbuf` and `so-sndbuf` not being granted, you can change this on your host machine. Please note that these changes are system-wide and affect all containers.

```
# Change current values
sysctl -w net.core.rmem_max=1048576
sysctl -w net.core.wmem_max=1048576

# Persist values across reboots
net.core.rmem_max=1048576
net.core.wmem_max=1048576
```

You can replace the `unbound.conf` file. I would suggest using the one in this repository as a basis. The `module-config`, `rpz` block, as well as the `remote-control` block are vital for the intended operation. Most other things are a bit more flexible. Image is published for:

- linux/amd64
- linux/arm64
- linux/arm/v7

However, my production usage is only on amd64.
