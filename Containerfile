FROM quay.io/pabrahamsson/hugo-asciidoctor:0.160@sha256:b59827e583651fe2896ccdfc121db997bac3e5b1999203262ed581c1167b8303 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1775074507@sha256:654db3e1eea5d465e3d5d0239ae45a62f027edf7b2583e89b79f58995e3b460d

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
