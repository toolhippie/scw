FROM ghcr.io/dockhippie/golang:1.25@sha256:281bd719bb68172a519fcc6b8ab8d90c00fa220042a687436a444790a1e6d098 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.51.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:290fa97fc3c00802b2a80f40cc21cdd5e6534a4422dcdb0abd57738ac08e86bf
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
