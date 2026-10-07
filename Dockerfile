FROM ghcr.io/dockhippie/golang:1.27@sha256:74a049afe4743969b7c913ea6c71ee1517bd8c4244225d21111cb4ced5064b4d AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.64.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:e0483a32bcd11999313e31a424fb40967f605ff34d7f09f02ee1732a14fd9071
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
