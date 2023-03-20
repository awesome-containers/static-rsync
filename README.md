# Statically linked Rsync

Statically linked [Rsync] container image with [Bash]

> 4,7M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-rsync:latest
ghcr.io/awesome-containers/static-rsync:3.2.7

docker.io/awesomecontainers/static-rsync:latest
docker.io/awesomecontainers/static-rsync:3.2.7
```

Slim statically linked [Rsync] container image with [Bash] stripped and
packaged with [UPX]

> 2,3M (578K bash)

```bash
ghcr.io/awesome-containers/static-rsync:latest-slim
ghcr.io/awesome-containers/static-rsync:3.2.7-slim

docker.io/awesomecontainers/static-rsync:latest-slim
docker.io/awesomecontainers/static-rsync:3.2.7-slim
```

[Rsync]: https://rsync.samba.org
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_RSYNC_IMAGE="$image" \
  --build-arg STATIC_RSYNC_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
