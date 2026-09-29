FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:9a8a86f76f4e3a7a44503da7f26506daece31114011cfc6a3569b199a0f8c59b as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:5789c51469c2ac47556445a7b1c433414e52a40f3d07ce3279e87c8d128e32f6

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
