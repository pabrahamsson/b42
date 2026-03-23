FROM quay.io/pabrahamsson/hugo-asciidoctor:0.158@sha256:ccf01e9f4827741ee3e4d8544b6d900a745619b27c00a06d8c37aff59ed9a332 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1774281219@sha256:9a9338207078ec51f6c58d2421c6e3f42b54277d03629467fc447d7823503920

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
