FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:cfe3ab8f1d4186a32845c9571e623c4ffed2d5a79edbc61d4253a17f6f02623b as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:99374633510dc80b762aac4f02a7e7dcf484ce070cb65cf34939d81abb313424

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
