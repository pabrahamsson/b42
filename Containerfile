FROM quay.io/pabrahamsson/hugo-asciidoctor:0.169@sha256:ed0a0d58cd3e0105264c1bcd44a1e9d69bb2244d1589e6b01b6bdca66a436fe5 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:8c67b090cf1abe69c03ee6c95af82bc7aa2b5ff488cd0336c50f3ccdbba3aad7

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
