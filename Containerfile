FROM quay.io/pabrahamsson/hugo-asciidoctor:0.168@sha256:28ddc409b2b1de110e789b503da09850644b7c70e75812748a418adcafbfdc2f as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:63ef79903a967e6bf45ed76e7c5f8bf28fb7457931162e0d645e75bcdeee0c49

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
