FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:69e317dbad406cfc44239f83171227f516ca04d774cc7335a2b7d9ed3228d24f as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:d35cbf4710c857ab7488914c8ab98c0d02ea954f225f928bfb1f708542605200

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
