FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:32907196c5659777a5c1ffa204d646392eb70a450ca81daeaafb9ac6299150dc as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:ea3f075e50f48a3c5ed56c913ff37b91b67561ed62313f8248534e2cb6209225

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
