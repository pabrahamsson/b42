FROM quay.io/pabrahamsson/hugo-asciidoctor:0.161@sha256:89cedb4c9c7322cacbb059594a4fdfd110caba3dc81d1af608050def47a488a5 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:1a39e682cb4cd23def8578d3e9c2784798e8ccb718d30257d429b67dd448fe33

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
