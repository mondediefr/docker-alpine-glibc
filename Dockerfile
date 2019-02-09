FROM alpine:3.9

ARG GLIBC_VER="2.28-r0"
ARG BUILD_DATE

LABEL description="glibc on alpine" \
      tags="latest 2.28-r0 2.28 2" \
      maintainer="mondediefr <https://github.com/xataz> <https://mondedie.fr>" \
      build_ver=${BUILD_DATE}

ENV GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    GLIBC_BASE_PACKAGE="glibc-$GLIBC_VER.apk" \
    GLIBC_BIN_PACKAGE="glibc-bin-$GLIBC_VER.apk" 

RUN apk add --no-cache --upgrade --virtual=.build_deps wget \
                                             ca-certificates \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget "$GLIBC_BASE_URL/$GLIBC_VER/$GLIBC_BASE_PACKAGE" \
            "$GLIBC_BASE_URL/$GLIBC_VER/$GLIBC_BIN_PACKAGE" \
    && apk add --no-cache \
                    "$GLIBC_BASE_PACKAGE" \
                    "$GLIBC_BIN_PACKAGE" \
    && apk del --no-cache .build_deps \
    && rm -f "$GLIBC_BASE_PACKAGE" \
             "$GLIBC_BIN_PACKAGE" \
             /etc/apk/keys/sgerrand.rsa.pub 
