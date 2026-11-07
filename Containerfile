FROM quay.io/pabrahamsson/hugo-asciidoctor:0.169@sha256:e33276003d4a712ca587217f6aeaf69c89862d1c481695890beb1590bad92a27 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:8c67b090cf1abe69c03ee6c95af82bc7aa2b5ff488cd0336c50f3ccdbba3aad7

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
