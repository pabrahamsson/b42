FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:2753eaaaace8e0eafa7fbe788e015f607c370af6bd17d4824217f1556991cadb as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:9bafc6b5266ee8b5e7285310747bff6d5eb9e732c5adaa3adcb7098e0e3f7a9a

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
