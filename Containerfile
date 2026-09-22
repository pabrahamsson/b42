FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:45bdddd42f5d33b7e9919364b622b84f754f1801b04fe67919ffbcd4d931329c as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:ea3f075e50f48a3c5ed56c913ff37b91b67561ed62313f8248534e2cb6209225

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
