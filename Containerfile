FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:937ddd22a464907d7de3ddc86841d661f1681d076d5daf66d99f50ab291cc157 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:936dcfb92c53a9e536f72cb5d4360e58ce7814cfcc9033cf85446c7b0f5f7a45

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
