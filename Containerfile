FROM quay.io/pabrahamsson/hugo-asciidoctor:0.153-1767223961@sha256:5fd5b0679fd6acda1aa9f9c54939f8e27cd7337850e01a8c221430a1fb9e34eb as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1770236895@sha256:f51afbf00a86bb1fdaeaf320f73c3386a18456ed6823adb877ec9439c2f8ede6

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
