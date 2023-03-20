# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# hadolint ignore=DL3018
RUN apk add --no-cache acl-dev attr-dev lz4-static lz4-dev zstd-dev openssl-dev openssl-libs-static

# https://github.com/WayneD/rsync
# https://rsync.samba.org/download.html
ARG RSYNC_VERSION=3.2.7

WORKDIR /src/rsync
RUN set -xeu; \
    curl -#Lo rsync.tar.gz \
        "https://download.samba.org/pub/rsync/src/rsync-$RSYNC_VERSION.tar.gz"; \
    tar -xvf rsync.tar.gz --strip-components=1; \
    rm -f rsync.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./configure --disable-xxhash; \
    make -j"$(nproc)"; \
    strip -s -R .comment --strip-unneeded rsync; \
    chmod -cR 755 rsync; \
    chown -cR 0:0 rsync; \
    ! ldd rsync && :; \
    ./rsync -V

# static rsync image
FROM static-bash
COPY --from=build /src/rsync/rsync /src/rsync/rsync-ssl /bin/
