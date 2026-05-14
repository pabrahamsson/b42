FROM quay.io/pabrahamsson/hugo-asciidoctor:0.161@sha256:25d675e5825c06b4d4fb5fdac1caa6f6b6a37eb2209149822c8d6e67a6bc0b1a as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:74c2f803c4788e2fce3e71b0e68f4b24fb4acb99d6a0b415a216d53082ae6c59

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
