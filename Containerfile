FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:d23af3c2734b9bb6c8dccd49e562e5049e9e5575f7e9820241e75e21737011df as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:634cd17a93d80044d6e67072cc3716a3b25134e41101436563eae4c56b9a802b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
