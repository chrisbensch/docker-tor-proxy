FROM alpine:latest AS builder

RUN apk update && \
  apk upgrade && \
  apk add git make go

RUN git clone https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird.git && \
    cd lyrebird && \
    make build


FROM alpine:latest AS final

RUN apk update && \
  apk upgrade && \
  apk add tor nyx && \
  rm /var/cache/apk/*

COPY --from=builder /lyrebird/lyrebird /usr/bin/lyrebird

COPY ./torrc.lyrebird /etc/tor/torrc

EXPOSE 9050 9051

USER tor
ENTRYPOINT ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
