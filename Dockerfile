FROM ghcr.io/dockhippie/golang:1.27@sha256:94626743282f0483614d8fe47e87857a9c3c588955c3ca37c2ea8fc3e0fea154 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.65.2

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:1194c744e2b2a03ecb3214aecb89005830fa422b4a8f84cd12951d6d29df7a4c
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
