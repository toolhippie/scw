FROM ghcr.io/dockhippie/golang:1.25@sha256:c70adbf1b1da840948e58ab2b318f937ad2dd9ae6f985ee699cc8df9c29779f1 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.55.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:3bf7f59a8892a380680d78bca46222cf369b5666a04e682c6a9622b32391fd8d
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
