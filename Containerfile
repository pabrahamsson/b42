FROM quay.io/pabrahamsson/hugo-asciidoctor:0.169@sha256:a46d1c4b9c4925a13ffd69404ea49c7e9394eba1eb00c805ea4b760e1c040dee as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:a6fa6830351d87da75272bc7597af100f52b5ed45fcb58be71ef1336e25e6df1

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
