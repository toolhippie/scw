FROM ghcr.io/dockhippie/golang:1.25@sha256:8738e214106887c70a12c6efc61f4bfd7044549462bca103a7773f707ccd1019 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.50.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:5e39b361571bce625f139dea01d8adec6219f266e3517886e48c0134948d6df8
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
