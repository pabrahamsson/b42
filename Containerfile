FROM quay.io/pabrahamsson/hugo-asciidoctor:0.157@sha256:cce02ab5cd9a6c015b1abff78ae86b2f3fb43e4addfe764cf0a6e54dd968898c as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.1-1773808734@sha256:fbf07b9047e6d49a87ff2ff1353eb052433861d18501b1b1e60d61d0d5a30a60

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
