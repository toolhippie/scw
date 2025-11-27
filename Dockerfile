FROM ghcr.io/dockhippie/golang:1.23@sha256:1ddfddfd3e2655f697c7d76652c98d1f6c1bb3c53face26d2b56c240a2ae974b AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.46.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.22@sha256:5b36d6c9994b3dbde7ff8e6140558b673d4ceb4d794c586073b934585c064a37
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
