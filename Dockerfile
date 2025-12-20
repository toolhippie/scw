FROM ghcr.io/dockhippie/golang:1.25@sha256:d7739fa0cdc9e723674174c819d98cd2b532d28aa5ea9abb33192218c2d56df2 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.49.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:f857559a03da3017be1663750116349e56d315cf0f86e64f508aa0613a9ef313
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
