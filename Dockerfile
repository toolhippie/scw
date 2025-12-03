FROM ghcr.io/dockhippie/golang:1.23@sha256:c216fc815d94e3ca49a7db76b45742d1ded5237eb870bfa2441c3642835ac107 AS build

# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.46.0

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM ghcr.io/dockhippie/alpine:3.22@sha256:29332ffd57d5b3922d93a7e0d47484f5da7a963fc8dfd7654ec10a48bf36a20f
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
