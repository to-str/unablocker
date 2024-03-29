@default: rm build run log


@build:
        docker build --tag tostr7191/unablocker .

@run: rm
        docker run -dit \
        --name unablocker_dev -p1337:53/udp tostr7191/unablocker:latest

@log:
        docker logs -f unablocker_dev

@rm:
        docker rm --force unablocker_dev

@publish:
        docker buildx build \
        --platform linux/amd64,linux/arm64,linux/arm/v7 . \
        --push -t tostr7191/unablocker
