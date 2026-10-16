FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:d23af3c2734b9bb6c8dccd49e562e5049e9e5575f7e9820241e75e21737011df as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:63ef79903a967e6bf45ed76e7c5f8bf28fb7457931162e0d645e75bcdeee0c49

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
