FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:937ddd22a464907d7de3ddc86841d661f1681d076d5daf66d99f50ab291cc157 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:d4fe4078bbaac0e9bd18fe53ec0e4cb8d80895ed19994fca2134eed3ecc09287

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
