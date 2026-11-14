FROM quay.io/pabrahamsson/hugo-asciidoctor:0.169@sha256:229a99fb17f61438e89f2d7aca0ce61e68c98c5a4d4b01f2805e923dd37b0427 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:3e332f55e250629b2cb6fe9df45ada87b169b0a366b2f8af246764c62fa869b2

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
