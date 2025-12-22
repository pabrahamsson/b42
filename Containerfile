FROM quay.io/pabrahamsson/hugo-asciidoctor:0.152.2-1761338925@sha256:007ebc08c56915a6297e31e11b6a099c6e5a38e4baf963d38b6a40bd33a3fc74 as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1766364117@sha256:e5d4e59446bae119ade983090670218f5db3cfd36cd0e22e17a22d6071022e71

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
