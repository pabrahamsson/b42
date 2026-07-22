FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:937ddd22a464907d7de3ddc86841d661f1681d076d5daf66d99f50ab291cc157 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:cfecd5f338214c713337ac158e57b50401a5116eae4f2f573bf61a1e20948a33

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
