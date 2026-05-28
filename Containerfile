FROM quay.io/pabrahamsson/hugo-asciidoctor:0.162@sha256:af145909c07d757e8deab3046cfd7c9070f4eeafad24e59b1356928f25bedbd8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:63e77c95ebaf33cdb95d092886c3bafae6c3e6d51b1c75f0d3d231322685c64f

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
