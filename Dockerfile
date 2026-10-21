FROM ghcr.io/dockhippie/golang:1.27@sha256:f22ede2fa1f47619bb5f904ce6b1bc04eb7813866a883c527c4ae9064d598368 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.65.2

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.23@sha256:b2f0d0b2460a72855e02bbb1c62bd1b6387c70da93984d4c8ea3e85f5dbfd4a8
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
