FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add tor && \
  rm /var/cache/apk/*

COPY ./torrc /etc/tor/torrc

EXPOSE 9050 9051

USER tor
CMD /usr/bin/tor -f /etc/tor/torrc
