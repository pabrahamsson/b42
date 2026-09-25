FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:32907196c5659777a5c1ffa204d646392eb70a450ca81daeaafb9ac6299150dc as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:b1a78d4e21c3d3d820918253b4a260009c7cd5f5edf1831c8f490f1afac3b064

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
