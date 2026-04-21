FROM quay.io/pabrahamsson/hugo-asciidoctor:0.160@sha256:6b130a2b3eadc54f3ee2e6ae03db56b0f8f6d6ddc3e3f792a09cdea6628ce3e5 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1776735323@sha256:bcc3a2f915e4d6b2b09924fec0119acb72a67605b98108779b6ea644ddcf091b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
