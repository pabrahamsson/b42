FROM quay.io/pabrahamsson/hugo-asciidoctor:0.167@sha256:0c419de2b3e192f4503c5c98d16d909f3d5e3df727c5a3f56fbef47b25bb5313 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:b13e50cc2dad4f27ce4efd375bb68aeef51d08493d82fbac3930ab863298e7df

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
