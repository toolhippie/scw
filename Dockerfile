FROM webhippie/alpine:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/toolhippie/scw.git"
LABEL org.label-schema.name="Scw"
LABEL org.label-schema.vendor="Thomas Boerger"
LABEL org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/scw"]
COPY release/linux/amd64/scw /usr/bin/
