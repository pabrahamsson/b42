FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:a610a8cc15038ec41cf0ab5325efe8fd8f38fa09ec8ac08213d95ec1a2205277 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:1d988f28b2c8e8faf3dc4a5e7ff2cb01b97371cfdeb640b6a554d02784a6e7f2

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
