FROM quay.io/pabrahamsson/hugo-asciidoctor:0.166@sha256:69e317dbad406cfc44239f83171227f516ca04d774cc7335a2b7d9ed3228d24f as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:76f7ebe2fa54204b6cacc88c126d77cad2e8d318cd748f8074f84365c89599cb

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
