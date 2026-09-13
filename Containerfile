FROM quay.io/pabrahamsson/hugo-asciidoctor:0.165@sha256:3ddc82f2155362146e66f0b4cda760e94a13c0039b499c8b9eae544e272b7136 as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:76f7ebe2fa54204b6cacc88c126d77cad2e8d318cd748f8074f84365c89599cb

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
