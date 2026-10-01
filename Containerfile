FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:2753eaaaace8e0eafa7fbe788e015f607c370af6bd17d4824217f1556991cadb as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:5789c51469c2ac47556445a7b1c433414e52a40f3d07ce3279e87c8d128e32f6

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
