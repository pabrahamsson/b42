FROM quay.io/pabrahamsson/hugo-asciidoctor:0.162@sha256:a0d432fc6fc40b111e19f22ccd9958d0ea768eee0dcac08c4b4212362a47a84b as BUILDER

ADD . /blog
RUN hugo

FROM quay.io/hummingbird/nginx:1.30@sha256:8209dee07c682e0bbc061c5f806bc4b71661a2476840c317aa711fd2f074c381

LABEL org.opencontainers.image.source https://github.com/pabrahamsson/b42

COPY --from=BUILDER /blog/public/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
