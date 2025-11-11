FROM ghcr.io/dockhippie/golang:1.23@sha256:8d1cff06bc3ad04ddc93f0b5346deb48d4079d4a69da49acb207c0c0010041f4 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.45.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.22@sha256:c5bd9014e136d50a0d82c511a4fcf52a2ef43c55d9d535de035870845d1a98be
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
