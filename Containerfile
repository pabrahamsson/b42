FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:a610a8cc15038ec41cf0ab5325efe8fd8f38fa09ec8ac08213d95ec1a2205277 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:b1bbfddce1c8f8582a8366d91b29d4d498717fc792724db0a7c3ae74de51fcba

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
