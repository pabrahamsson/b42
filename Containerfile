FROM quay.io/pabrahamsson/hugo-asciidoctor:0.159@sha256:1f4d1076c0b4966c165430d36efc9dcd5a9792b7dd0b3b9ad2dfe0274c731414 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1775074507@sha256:654db3e1eea5d465e3d5d0239ae45a62f027edf7b2583e89b79f58995e3b460d

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
