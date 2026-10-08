FROM ghcr.io/dockhippie/golang:1.27@sha256:5895f4c57af46ff2f79b26acf6323145905d3bb6b7227c93d666473f7ec7ec60 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.65.1

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:e0483a32bcd11999313e31a424fb40967f605ff34d7f09f02ee1732a14fd9071
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
