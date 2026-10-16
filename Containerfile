FROM quay.io/pabrahamsson/hugo-asciidoctor:0.168@sha256:4c093deacfe298e0b14b313b2f8f85d4a96a9cf96b4ca02028ef9974cffe6afa as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:634cd17a93d80044d6e67072cc3716a3b25134e41101436563eae4c56b9a802b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
