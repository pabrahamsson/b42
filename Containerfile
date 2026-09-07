FROM quay.io/pabrahamsson/hugo-asciidoctor:0.165@sha256:8a9a9a4bf00d7ce59c6f8604171a02d3bb1ce90025ca9fbcdbb924d02187becb as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:3efe0deba4a61f5b2a2eb31d1deab3a8d349578322cc7ccc476a27d24dc72c0e

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
