FROM ghcr.io/dockhippie/golang:1.25@sha256:e5cbcecb54099c088e4d1a2eda7b1581b709e33adaf4aed25d62e2b35fbc5ddb AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.56.3

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:22643f7f07c00c4d953eda05288488b2923f0b23c92b571303b3f5c3a4e6814e
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
