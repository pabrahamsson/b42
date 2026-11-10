FROM quay.io/pabrahamsson/hugo-asciidoctor:0.169@sha256:d841e67d3e4fb8f7ba5395b189ac0296ba236dd6cf3934849afd4c6c2fa7a302 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:53d13cb6557d4bf51cb24665b610a4f5281e4af204e44ac748097fa320c747f7

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
