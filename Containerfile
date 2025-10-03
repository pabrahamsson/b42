FROM quay.io/pabrahamsson/hugo-asciidoctor:0.148.2-1 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.0

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
