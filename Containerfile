FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:937ddd22a464907d7de3ddc86841d661f1681d076d5daf66d99f50ab291cc157 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:03fdc8a86b85b99fd0424c5969a947586a33d644590fdcdb8b31d3edeaa5b84d

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
