FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:a610a8cc15038ec41cf0ab5325efe8fd8f38fa09ec8ac08213d95ec1a2205277 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:9043bbc064b09d2b85c8831a24ce5c5c0d1357edcd4af0fc51153367fbb7a105

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
