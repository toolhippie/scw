FROM webhippie/golang:1.17 AS build

# renovate: datasource=github-tags depName=scaleway/scaleway-cli
ENV SCW_VERSION=v2.4.0

RUN git clone -b ${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM webhippie/alpine:latest
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
