FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:2753eaaaace8e0eafa7fbe788e015f607c370af6bd17d4824217f1556991cadb as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:9f3cd5c33ae54c28278cdd29d709799f18c28484d7041e3fae91daba1176c5a7

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
