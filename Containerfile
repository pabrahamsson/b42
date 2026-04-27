FROM quay.io/pabrahamsson/hugo-asciidoctor:0.160@sha256:43c5611c6f5c1c9c6b6df1b8027de1fbd83526bf2186b181f383c840e3bde51f as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1776906374@sha256:77d9ff8c889d48f1f068d0599f115b797154c5a14bb0fb57d45f809e4a244245

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
