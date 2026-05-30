FROM quay.io/pabrahamsson/hugo-asciidoctor:0.162@sha256:2c259f9fcf2fdf53a59f24bb0e1e1e824601e673d92754618a99c2bfadceadbf as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:f4816ea71e8379af9ac9fc2327c31c3c0bdd18baf623e3b425ef924103fd40d4

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
