FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:c590dc14cea56bafd6c4d2e7865123bf11413ebef5abbc81b9c9bb743dc15d73 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:b13e50cc2dad4f27ce4efd375bb68aeef51d08493d82fbac3930ab863298e7df

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
