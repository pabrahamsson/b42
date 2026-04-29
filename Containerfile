FROM quay.io/pabrahamsson/hugo-asciidoctor:0.160@sha256:43c5611c6f5c1c9c6b6df1b8027de1fbd83526bf2186b181f383c840e3bde51f as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1777437441@sha256:98353029175cbdc7984d9d83eb613c7483d17e905c2909b00330de90a87d3ad6

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
