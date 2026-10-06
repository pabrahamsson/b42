FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:0c419de2b3e192f4503c5c98d16d909f3d5e3df727c5a3f56fbef47b25bb5313 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:e793ca0c2be85e5113b8732248b8100a795f412374434af36fd4cf665e32764b

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
