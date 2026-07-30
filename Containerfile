FROM quay.io/pabrahamsson/hugo-asciidoctor:0.164@sha256:c529d2dc5b9bb6eabe7278f702f6e11098a0d46a793c2ef7d35fe89cedb22078 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:6ce6d750ff8a3db063377c9736ff26d0def421074eab127a8eb0dd86e2acf451

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
