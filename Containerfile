FROM quay.io/pabrahamsson/hugo-asciidoctor:0.170@sha256:39c875536579d50b18f1d5e8f9d65027c032012a586925083f56e4d462317fd8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e91520eb223fc92e5e7623cda9d4f71812ca76d7b0eee584274b824511b719fa

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
