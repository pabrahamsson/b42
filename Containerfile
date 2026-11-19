FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:39c875536579d50b18f1d5e8f9d65027c032012a586925083f56e4d462317fd8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:3e332f55e250629b2cb6fe9df45ada87b169b0a366b2f8af246764c62fa869b2

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
