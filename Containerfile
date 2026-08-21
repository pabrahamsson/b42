FROM quay.io/pabrahamsson/hugo-asciidoctor:0.165@sha256:1a20097ac591fc3241c6d7a77f9d9642f76ec44502d92ef975d848e9680a9d1d as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e2a2fff8bd56b24ed6e94b09c3e94f637fe54cef7557ff862cef4363d95f064b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
