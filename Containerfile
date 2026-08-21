FROM quay.io/pabrahamsson/hugo-asciidoctor:0.164@sha256:743325b52cd96d82aa197cc0f3e93a94b140cb990e700e9c8258807cec1848f8 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:36ece5181301b52891fa1bfe5a8530ee89501c92b54de0cc0247542c8623838e

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
