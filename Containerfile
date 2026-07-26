FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:937ddd22a464907d7de3ddc86841d661f1681d076d5daf66d99f50ab291cc157 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:387f62733010d5e4dac5d27e9944e64ce00008e16d4bc26d8339de45e18bbe6b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
