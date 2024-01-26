FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add tor nyx && \
  rm /var/cache/apk/*

COPY ./torrc /etc/tor/torrc

EXPOSE 9050 9051

USER tor
ENTRYPOINT ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
