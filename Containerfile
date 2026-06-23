FROM quay.io/pabrahamsson/hugo-asciidoctor:0.163@sha256:cfe3ab8f1d4186a32845c9571e623c4ffed2d5a79edbc61d4253a17f6f02623b as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e2be644f0e3a9f2cb68104aa6bc5690f04382a746ec01ee379e0eaaf81a8098b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
