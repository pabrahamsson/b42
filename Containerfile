FROM quay.io/pabrahamsson/hugo-asciidoctor:0.150.1-1@sha256:4f04701b581eecb6aa8a4d8b7b69cc06e84602e63330f03afa1a15d054779f2a as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.0-1760573692@sha256:f147757191d867de6a9f80d1096d041bff03e9871acf6e1d588975e2cba3b1f0

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
COPY --chown=1001:0 ./nginx.conf /tmp/src/nginx.conf
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
