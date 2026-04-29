FROM quay.io/pabrahamsson/hugo-asciidoctor:0.161@sha256:1f57b3cfc16eba88a39fa17be9e7d7ccf00cfc6d27e41d52bf68ead9e35b4dd1 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:c92efeac2a74d7334733f94b505c611a5b928971b766fe73c9ccf594e46c0a1b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
