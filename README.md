# unablocker

## Description

unablocker, a combination of unbound and adblock, is a container that acts as a DNS server while also blocking a lot of unwanted ad networks.

It is based on
- [unbound](https://nlnetlabs.nl/projects/unbound/about/)
- [unbound-adblock](https://www.geoghegan.ca/unbound-adblock.html) by Jordan Geoghegan
- [alpine docker image](https://gitlab.alpinelinux.org/alpine/infra/docker/unbound)

The image from alpine is not pulled, I adapted the original Dockerfile to make everything easy to follow. If you run this container you need to map port 53. Unbound with the default config is running as a recursive, iterative resolver, and does not forward queries to other DNS servers. This can easily be changed in the config. The docker image can be found [here](https://hub.docker.com/repository/docker/tostr7191/unablocker/general).

## Running

Simplest way of running is

```
docker pull tostr7191/unablocker:latest
docker run -dit -p53:53/udp --name unablocker tostr7191/unablocker:latest
```

You can replace the `unbound.conf` file, I would suggest using the one in this repository as a basis. The `module-config`, `rpz` block, as well as the `remote-control` block are vital for the intended operation. Most other things are a bit more flexible. Right now the image is only published for `amd64`, I will adapt this in the future.
