@build:
        docker buildx build --platform linux/amd64 --tag tostr7191/unablocker .

@run:
        docker run -dit --name unablocker -p53:53/udp tostr7191/unablocker:latest
        docker logs -f unablocker

@pull:
        docker pull tostr7191/unablocker

@push:
        docker push tostr7191/unablocker 

@rm:
        docker rm --force unablocker
