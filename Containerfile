FROM quay.io/pabrahamsson/hugo-asciidoctor:0.161@sha256:25d675e5825c06b4d4fb5fdac1caa6f6b6a37eb2209149822c8d6e67a6bc0b1a as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:6617c51361471269b0ca97baf0624527a54a2ca2b82fce70bbae4ed2813e5a29

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
