FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:e1313ba10900cc75d4d6498fce7fbff7ce19f5f8c5f2275ea9b02952382e7c90 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e2be644f0e3a9f2cb68104aa6bc5690f04382a746ec01ee379e0eaaf81a8098b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
