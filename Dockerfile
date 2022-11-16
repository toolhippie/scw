FROM webhippie/golang:1.19 AS build

<<<<<<< Updated upstream
# renovate: datasource=github-tags depName=scaleway/scaleway-cli
ENV SCW_VERSION=v2.6.2
=======
# renovate: datasource=github-releases depName=scaleway/scaleway-cli
ENV SCW_VERSION=2.5.3
>>>>>>> Stashed changes

RUN git clone -b v${SCW_VERSION} https://github.com/scaleway/scaleway-cli.git /srv/app/src && \
  cd /srv/app/src && \
  GO111MODULE=on go install ./cmd/scw

FROM webhippie/alpine:3.16
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/scw /usr/bin/
