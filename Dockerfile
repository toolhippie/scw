FROM ghcr.io/dockhippie/golang:1.27@sha256:a1141a722e4dc549b8965740c0d818be8bd17ade52a565687b7e449871bc2353 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.67.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:a95a9a4236d9d8ea9250ac367ab8d83b161493788c5e05394c74ac5c95320875
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
