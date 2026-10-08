FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:2753eaaaace8e0eafa7fbe788e015f607c370af6bd17d4824217f1556991cadb as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:7c88ec5f1177a2ab937e3fb99c3e42c367c629a7632e5c90a9dc607a9e4d1dcc

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
