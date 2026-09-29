FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:32907196c5659777a5c1ffa204d646392eb70a450ca81daeaafb9ac6299150dc as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:5789c51469c2ac47556445a7b1c433414e52a40f3d07ce3279e87c8d128e32f6

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
