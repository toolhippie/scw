FROM ghcr.io/dockhippie/golang:1.25@sha256:a642b447d9d055cd3152c802c3f8abd5099f672042f21dd5e8f1bbbaa9cd5aa0 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.51.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:a674aadc1cccd2f424673c7596eff46336210016a50c8082849071f78bb15105
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
