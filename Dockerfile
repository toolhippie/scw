FROM ghcr.io/dockhippie/golang:1.26@sha256:573c3b82a8e452a2aaf0eea23e4f5b5f562c1252d1bae56c32a18223e79d9595 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.58.3

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:1cb712df5842561657169b93b1845cffa82de67560125cf22d49639566e32c1e
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
