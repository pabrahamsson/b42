FROM quay.io/pabrahamsson/hugo-asciidoctor:0.164@sha256:c529d2dc5b9bb6eabe7278f702f6e11098a0d46a793c2ef7d35fe89cedb22078 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e2a2fff8bd56b24ed6e94b09c3e94f637fe54cef7557ff862cef4363d95f064b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
