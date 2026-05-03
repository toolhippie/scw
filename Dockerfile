FROM ghcr.io/dockhippie/golang:1.25@sha256:26330f9326ba939d2b4bf5af25e2bc8d239d9ff59d65f807ebfbd3443e8acdd8 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.55.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:629cd5472f21a622e37a9afabdbd39f489dd22a7fe1e4ced6a0db63589e85dfa
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
