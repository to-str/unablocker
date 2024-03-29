@publish:
        docker buildx build \
        --platform linux/amd64,linux/arm64,linux/arm/v7 . \
        --push -t tostr7191/unablocker

@build:
        docker build --tag tostr7191/unablocker .

@run:
        docker run -dit \
        --name unablocker -p53:53/udp tostr7191/unablocker:latest
        docker logs -f unablocker

@run-sysctl:
        docker run -dit \
        --sysctl net.core.rmem_max=1048576 \
        --sysctl net.core.wmem_max=1048576 \
        --name unablocker -p53:53/udp tostr7191/unablocker:latest
        docker logs -f unablocker

@pull:
        docker pull tostr7191/unablocker

@push:
        docker push tostr7191/unablocker 

@rm:
        docker rm --force unablocker
