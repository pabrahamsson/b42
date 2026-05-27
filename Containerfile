FROM quay.io/pabrahamsson/hugo-asciidoctor:0.161@sha256:235722d988f48ae72f68a7b1b9ffc2ba8884eba3bd9bb3ab98267ecee66b19d4 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:11efb42cb6c499ce5d6f4563bab2bb502ac5a4cee5d840dc02d020d871112170

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
