FROM quay.io/pabrahamsson/hugo-asciidoctor:0.162@sha256:af145909c07d757e8deab3046cfd7c9070f4eeafad24e59b1356928f25bedbd8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:f4816ea71e8379af9ac9fc2327c31c3c0bdd18baf623e3b425ef924103fd40d4

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
