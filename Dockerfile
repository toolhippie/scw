FROM ghcr.io/dockhippie/golang:1.26@sha256:6452f324724ef782b1bcf874c77bbe9a368bc300690b01ab81940bb3f61456ff AS build

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
