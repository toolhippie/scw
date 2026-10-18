FROM ghcr.io/dockhippie/golang:1.27@sha256:28f7eef0a0f52c7b7898635a5970f4f05b76d91c0aa5b25089069bcf1b477cf7 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.65.1

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:f07d501357a45f80b1c874224206284cde04a4fa8e7b8784dff9f7d6fa5360f1
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
