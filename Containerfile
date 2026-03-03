FROM quay.io/pabrahamsson/hugo-asciidoctor:0.157@sha256:cce02ab5cd9a6c015b1abff78ae86b2f3fb43e4addfe764cf0a6e54dd968898c as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1772526262@sha256:53bd27444054cf2fda020c1886d2e5322a47f26412ffd6537a1d8894d05fb817

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
