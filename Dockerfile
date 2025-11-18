FROM ghcr.io/dockhippie/golang:1.23@sha256:bfe48e6e069deaf3b5ba5555776394494a6cd0ea55d6569ed88df55fa4c61fdd AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.45.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.22@sha256:8c689fb24e65bb97d02d9224435dd07c6c94939a09b8bcae903e1bc5b87ae9ad
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
