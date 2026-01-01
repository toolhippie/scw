FROM ghcr.io/dockhippie/golang:1.25@sha256:b3021effd09e56deb82e6e3a79e027cebb78c9cee8f369536b8f66bbd11776dd AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.49.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:5e39b361571bce625f139dea01d8adec6219f266e3517886e48c0134948d6df8
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
