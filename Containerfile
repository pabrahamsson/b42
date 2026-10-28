FROM quay.io/pabrahamsson/hugo-asciidoctor:0.168@sha256:ea39b9575f2a9d460f4609a913dec8a1e0c54c5e8e2c3294d975210cf75ef763 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:63ef79903a967e6bf45ed76e7c5f8bf28fb7457931162e0d645e75bcdeee0c49

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
