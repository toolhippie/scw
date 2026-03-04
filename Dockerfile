FROM ghcr.io/dockhippie/golang:1.25@sha256:e53b907d2e20196c9b98de089693feebb0315bfe9c74331532f9cce8b0d3e618 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.52.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:ab739d6c611c2153c817d6b8f56a4359be087703d563d539e08a475f2fcb72d3
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
