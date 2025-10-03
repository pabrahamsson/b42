FROM quay.io/pabrahamsson/hugo-asciidoctor:0.150.1-1@sha256:4f04701b581eecb6aa8a4d8b7b69cc06e84602e63330f03afa1a15d054779f2a as BUILDER

ADD . /blog
RUN hugo

FROM registry.access.redhat.com/ubi10/nginx-126:10.0-1758744794@sha256:0df9e18b00efd7e230c021e4511bab9904f59615d83421c178d611835a49f634

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

USER 1001
COPY --from=BUILDER --chown=1001:0 /blog/public /tmp/src
RUN /usr/libexec/s2i/assemble

CMD /usr/libexec/s2i/run
