FROM ghcr.io/dockhippie/golang:1.26@sha256:2c793d6edaa3aa629b956b72eaa5eb92933ae789bd41782ef5379aa513919a63 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.64.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:0c390b9f9e8a5a78f0fd573548d2a13e035893de9ed1342ebcb7d33e02a912c2
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
