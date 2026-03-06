FROM ghcr.io/dockhippie/golang:1.25@sha256:b21fe99f18791f62b3c3032e72cf90e37361414eea2cfd6c78db6ad0e4961256 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.52.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:c2218a341d02631f8fe99633a9daef146324b9a0b8a1269c2410446f04034319
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
