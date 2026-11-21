FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:a610a8cc15038ec41cf0ab5325efe8fd8f38fa09ec8ac08213d95ec1a2205277 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:492b997b5a4cb6925fcb5d2d133c58b9aa8d3c75b50ef83d5ad2ef354990086a

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
