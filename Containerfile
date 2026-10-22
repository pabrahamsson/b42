FROM quay.io/pabrahamsson/hugo-asciidoctor:0.168@sha256:28ddc409b2b1de110e789b503da09850644b7c70e75812748a418adcafbfdc2f as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:13d07ace4c45dcb623b6fbb826022d7ef86cce3a1d30491e1cf71dca39be4efb

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
