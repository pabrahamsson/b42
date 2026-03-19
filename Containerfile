FROM quay.io/pabrahamsson/hugo-asciidoctor:0.158@sha256:df81200efe989d808e062c8fc644b0ee0dabb08083f60c365cf19ea770543d3d as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1773893809@sha256:eb8c01dd97b3d4934929ca377e1949709befc8e08ceee22e50f1e7c655b5e632

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
