FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:3928ab7dd907a13850f7f63b4f18486d028343a5cf7e7d3b58173064425ef951 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:9bafc6b5266ee8b5e7285310747bff6d5eb9e732c5adaa3adcb7098e0e3f7a9a

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
