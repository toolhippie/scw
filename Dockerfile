FROM ghcr.io/dockhippie/golang:1.26@sha256:2c793d6edaa3aa629b956b72eaa5eb92933ae789bd41782ef5379aa513919a63 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.59.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:f797bd00305b8c250138cee4e3c9354cac69ea97bb03d76cf527a9200221ec95
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
