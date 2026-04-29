FROM quay.io/pabrahamsson/hugo-asciidoctor:0.160@sha256:43c5611c6f5c1c9c6b6df1b8027de1fbd83526bf2186b181f383c840e3bde51f as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:c92efeac2a74d7334733f94b505c611a5b928971b766fe73c9ccf594e46c0a1b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
