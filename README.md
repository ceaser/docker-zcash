# docker-zcash
A Linux ZCash node docker container.

## Examples

Here is an example of a docker run line that exposes all ports and mounts the data directory to persist blockchain and wallet files.

```SHELL
docker run -it -p '8233:8233/tcp' -v `pwd`/data:'/data' ceaser/zcash
```
