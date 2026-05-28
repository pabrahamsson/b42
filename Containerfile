FROM quay.io/pabrahamsson/hugo-asciidoctor:0.162@sha256:af145909c07d757e8deab3046cfd7c9070f4eeafad24e59b1356928f25bedbd8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:11efb42cb6c499ce5d6f4563bab2bb502ac5a4cee5d840dc02d020d871112170

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
